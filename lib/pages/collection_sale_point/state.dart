part of 'bloc.dart';

class CollectionSalePointState {
  const CollectionSalePointState({
    this.startDate="",
    this.endDate="",
    this.amount="",
    this.page = 0,
    this.isMore = false,
    this.agentCollectRecordList = const <AgentCollectRecordData>[],
  });

  final String? startDate;
  final String? endDate;
  final String? amount;
  final bool isMore;
  final int page;
  final List<AgentCollectRecordData> agentCollectRecordList;

  CollectionSalePointState copyWith({
    String? startDate,
    String? endDate,
    String? amount,
    bool? isMore,
    List<AgentCollectRecordData>? agentCollectRecordList,
    int? page
  }) {
    return CollectionSalePointState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      amount: amount ?? this.amount,
      agentCollectRecordList: agentCollectRecordList ?? this.agentCollectRecordList,
      page:page??this.page,
      isMore:isMore??this.isMore,
    );
  }
}
