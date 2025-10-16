part of 'bloc.dart';

class ReportState {
  const ReportState({
    this.collectionList = const <BaseData>[],
    this.page = 0,
  });

  final int page;
  final List<BaseData> collectionList;

  ReportState copyWith({List<BaseData>? collectionList, int? page}) {
    return ReportState(
      page: page ?? this.page,
      collectionList: collectionList ?? this.collectionList,
    );
  }
}
