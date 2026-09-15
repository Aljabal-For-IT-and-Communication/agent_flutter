import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'bloc.dart';

class Logic {
  final BuildContext context;
  Logic({
    required this.context,
  });

  init() {}

  Future<void> postTransferCollection(DateRequestEntity entity,
      {bool refresh = false}) async {
    final bloc = context.read<CollectionWhatBloc>();
    final state = bloc.state;
    final request = ++bloc.recordsRequestVersion;
    if (!refresh) {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
    }
    try {
      final totalEntity = DateRangeRequestEntity(
        startDate: entity.startDate,
        endDate: entity.endDate,
      );
      final total =
          await SalePointAPI.transferCollectionTotalRecord(params: totalEntity);
      if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
      final result = await SalePointAPI.transferCollectionList(params: entity);
      if (bloc.isClosed || request != bloc.recordsRequestVersion) return;
      // Keep the total and records from the same successful refresh together.
      if (total.code == 0 &&
          total.data != null &&
          result.code == 0 &&
          result.data != null) {
        bloc.add(AmountChanged(total.data!));
        bloc.add(AgentCollectRecordListChanged(entity.page == 0
            ? result.data!
            : [...state.agentCollectRecordList, ...result.data!]));
      }
    } catch (error) {
      Logger.write('$error');
    } finally {
      if (!refresh) EasyLoading.dismiss();
      if (!bloc.isClosed && request == bloc.recordsRequestVersion) {
        bloc.add(IsMoreChanged(false));
      }
    }
  }

  Future<List<AgentCollectRecordData>> getAllTransferCollection() async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      final state = context.read<CollectionWhatBloc>().state;
      DateRequestEntity entity = DateRequestEntity();
      entity.startDate = replaceArabicNumbers(state.startDate ?? "");
      entity.endDate = replaceArabicNumbers(state.endDate ?? "");
      entity.page = -1; // -1 for all records
      var result = await SalePointAPI.transferCollectionList(params: entity);
      Logger.write("getAllTransferCollection: idk");
      if (result.code == 0 && result.data != null) {
        EasyLoading.dismiss();
        Logger.write("getAllTransferCollection: ${result.data!.length}");
        return result.data!.toList();
      }
      EasyLoading.dismiss();
      return [];
    } catch (e) {
      EasyLoading.dismiss();
      Logger.write("${e}");
      return [];
    }
  }
}
