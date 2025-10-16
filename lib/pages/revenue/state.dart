part of 'bloc.dart';

class RevenueState {
  const RevenueState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.agentCollectRecordList = const <AgentCollectRecordData>[],
    this.agentItem,
    this.salePointItem,
    this.phone = "",
    this.Amount = "",
    this.type = "recharge",
    this.agent = "Agent",
    this.page = 0,
    this.isMore = false,
  });

  final String phone;
  final String Amount;
  final String type;
  final String agent;
  final int page;
  final bool isMore;
  final List<SalePointData> salePointList;
  final List<AgentData> agentList;
  final List<AgentCollectRecordData> agentCollectRecordList;
  final AgentData? agentItem;
  final SalePointData? salePointItem;

  RevenueState copyWith(
      {List<SalePointData>? salePointList,
      List<AgentData>? agentList,
      List<AgentCollectRecordData>? agentCollectRecordList,
      AgentData? agentItem,
      SalePointData? salePointItem,
      String? phone,
      String? Amount,
      String? type,
      String? agent,
      bool? isMore,
      int? page}) {
    return RevenueState(
        salePointList: salePointList ?? this.salePointList,
        agentList: agentList ?? this.agentList,
        agentCollectRecordList:
            agentCollectRecordList ?? this.agentCollectRecordList,
        phone: phone ?? this.phone,
        Amount: Amount ?? this.Amount,
        type: type ?? this.type,
        agent: agent ?? this.agent,
        agentItem: agentItem ?? this.agentItem,
        salePointItem: salePointItem ?? this.salePointItem,
        isMore: isMore ?? this.isMore,
        page: page ?? this.page);
  }
}
