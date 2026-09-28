import 'package:app/common/apis/agent.dart';
import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/utils/recipient_report.dart';
import 'package:app/common/utils/recipient_report_pdf.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:printing/printing.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });

  init() {
    agent();
    salePoint();
  }

  salePoint() async {
    try {
      var result = await SalePointAPI.salePointPickerList();
      if (!context.mounted) return;
      if (result.code == 0 && result.data != null) {
        context.read<RevenueBloc>().add(SalePointChanged(result.data!));
        if (result.data!.isNotEmpty)
          context
              .read<RevenueBloc>()
              .add(SalePointItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  agent() async {
    try {
      var result = await AgentAPI.agentList();
      if (!context.mounted) return;
      if (result.code == 0 && result.data != null) {
        context.read<RevenueBloc>().add(AgentListChanged(result.data!));
        if (result.data!.isNotEmpty)
          context.read<RevenueBloc>().add(AgentItemChanged(result.data!.first));
      }
    } catch (e) {
      Logger.write("${e}");
    }
  }

  RecipientReportFilter _filter(RevenueState state) {
    final agent = state.agentItem;
    return RecipientReportFilter(
        category: state.agent,
        id: state.agent == 'Agent' ? agent?.id : state.salePointItem?.id,
        name: state.agent == 'Agent'
            ? [agent?.firstName, agent?.middleName, agent?.lastName]
                .where((part) => part != null && part.trim().isNotEmpty)
                .join(' ')
            : (state.salePointItem?.businessName ??
                state.salePointItem?.firstName ??
                ''),
        phone: (state.agent == 'Agent'
                ? agent?.phone
                : state.salePointItem?.phone) ??
            '',
        startDate: state.startDate,
        endDate: state.endDate);
  }

  Future<void> postTransformation(
      {bool refresh = false, bool showLoading = true}) async {
    final bloc = context.read<RevenueBloc>();
    final state = bloc.state;
    if (!refresh && (bloc.recordsLoading || !state.hasMore)) return;
    final filter = _filter(state);
    final error = filter.validationError;
    if (error != null) {
      toastInfo(msg: error.tr());
      return;
    }
    final request = ++bloc.recordsRequestVersion;
    bloc.recordsLoading = true;
    bloc.add(ReportLoadingChanged(request, true));
    if (showLoading) FocusManager.instance.primaryFocus?.unfocus();
    try {
      final result = await SalePointAPI.salePointCollectRecordList(
          params: filter
              .request(refresh ? 0 : state.agentCollectRecordList.length));
      if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
      if (result.code != 0 || result.data == null) {
        toastInfo(msg: trServerMessage(result.msg ?? 'Unable to load report'));
        return;
      }
      if (result.totalAmount == null) {
        toastInfo(msg: 'Report server update required'.tr());
        return;
      }
      // Validate the decimal before committing rows and total together.
      final total = sumReportAmounts([result.totalAmount!]);
      final records = refresh
          ? <AgentCollectRecordData>[]
          : state.agentCollectRecordList.toList();
      for (final item in result.data!) {
        if (!records.any((existing) => existing.id == item.id)) {
          records.add(item);
        }
      }
      bloc.add(ReportResultChanged(
          request, records, total, result.data!.length >= 8));
    } catch (error) {
      if (!bloc.isClosed && request == bloc.recordsRequestVersion) {
        toastInfo(msg: 'Unable to load report'.tr());
        Logger.write('$error');
      }
    } finally {
      if (!bloc.isClosed && request == bloc.recordsRequestVersion) {
        bloc.recordsLoading = false;
        bloc.add(ReportLoadingChanged(request, false));
      }
    }
  }

  Future<void> printReport() async {
    final bloc = context.read<RevenueBloc>();
    if (bloc.exporting) return;
    final filter = _filter(bloc.state);
    final error = filter.validationError;
    if (error != null) {
      toastInfo(msg: error.tr());
      return;
    }
    final filterVersion = bloc.filterVersion;
    final isArabic = context.locale.languageCode == 'ar';
    final title = 'Revenue Report'.tr();
    // Capture translations before awaiting, so PDF language cannot change midway.
    final labels = <String, String>{
      for (final key in [
        'Agent',
        'Sales Point',
        'Phone',
        'All history',
        'Select date from',
        'Select date to',
        'Report times are UTC+2; end time is excluded',
        'No data available',
        'Amount',
        'Collect Type',
        'Recharge Type',
        'Date',
        'Collect and Recharge Details',
        'Type',
        'Name',
        'Total Amount',
        'Overall Total'
      ])
        key: key.tr()
    };
    bloc.exporting = true;
    bloc.add(const ReportPrintingChanged(true));
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final result = await SalePointAPI.salePointCollectRecordList(
          params: filter.request(-1));
      if (bloc.isClosed || filterVersion != bloc.filterVersion) return;
      if (result.code != 0 || result.data == null) {
        toastInfo(msg: trServerMessage(result.msg ?? 'Unable to print report'));
        return;
      }
      if (result.totalAmount == null) {
        toastInfo(msg: 'Report server update required'.tr());
        return;
      }
      final rows = result.data!
          .map((item) => RecipientReportRow(
              amount: item.amount ?? '0',
              createdAt: item.createdAt ?? '',
              collectType: item.collectTypeName ?? '',
              rechargeType: item.rechargeTypeName ?? ''))
          .toList();
      // Do not print a partial or inconsistent export as though it were complete.
      if (sumReportAmounts(rows.map((row) => row.amount)) !=
          sumReportAmounts([result.totalAmount!])) {
        toastInfo(msg: 'Report changed; please try again'.tr());
        return;
      }
      final bytes = await buildRecipientReportPdf(
          title: title,
          filter: filter,
          rows: rows,
          isArabic: isArabic,
          translate: (key) => labels[key] ?? key);
      if (bloc.isClosed || filterVersion != bloc.filterVersion) return;
      await Printing.layoutPdf(
          name: 'revenue-report.pdf', onLayout: (_) async => bytes);
    } catch (error) {
      if (!bloc.isClosed && filterVersion == bloc.filterVersion) {
        toastInfo(msg: 'Unable to print report'.tr());
        Logger.write('$error');
      }
    } finally {
      bloc.exporting = false;
      if (!bloc.isClosed) bloc.add(const ReportPrintingChanged(false));
    }
  }
}
