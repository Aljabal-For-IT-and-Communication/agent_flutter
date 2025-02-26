part of 'bloc.dart';

class CollectionWhatState {
  const CollectionWhatState({
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
  final int page;
  final bool isMore;
  final List<AgentCollectRecordData> agentCollectRecordList;

  CollectionWhatState copyWith({
    String? startDate,
    String? endDate,
    String? amount,
    bool? isMore,
    List<AgentCollectRecordData>? agentCollectRecordList,
    int? page
  }) {
    return CollectionWhatState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      amount: amount ?? this.amount,
      agentCollectRecordList: agentCollectRecordList ?? this.agentCollectRecordList,
      page:page??this.page,
      isMore:isMore??this.isMore,
    );
  }
}
