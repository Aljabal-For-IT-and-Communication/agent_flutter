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

  postTransferCollection(DateRequestEntity entity) async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      final totalEntity = DateRangeRequestEntity(
        startDate: entity.startDate,
        endDate: entity.endDate,
      );
      var result1 =
          await SalePointAPI.transferCollectionTotalRecord(params: totalEntity);
      if (result1.code == 0) {
        context.read<CollectionWhatBloc>().add(AmountChanged(result1.data!));
      }

      var result = await SalePointAPI.transferCollectionList(params: entity);
      if (result.code == 0 && result.data != null) {
        if (result.data!.isNotEmpty) {
          final state = context.read<CollectionWhatBloc>().state;
          var agentCollectRecordList = state.agentCollectRecordList.toList();
          agentCollectRecordList.addAll(result.data!);
          context
              .read<CollectionWhatBloc>()
              .add(AgentCollectRecordListChanged(agentCollectRecordList));
        }
      }
      EasyLoading.dismiss();
      context.read<CollectionWhatBloc>().add(IsMoreChanged(false));
    } catch (e) {
      EasyLoading.dismiss();
      context.read<CollectionWhatBloc>().add(IsMoreChanged(false));
      Logger.write("${e}");
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
