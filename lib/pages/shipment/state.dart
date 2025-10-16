part of 'bloc.dart';

class ShipmentState {
  const ShipmentState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.agentRechargeRecordList = const <AgentRechargeRecordData>[],
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
  final List<AgentRechargeRecordData> agentRechargeRecordList;
  final AgentData? agentItem;
  final SalePointData? salePointItem;

  ShipmentState copyWith(
      {List<SalePointData>? salePointList,
      List<AgentData>? agentList,
      List<AgentRechargeRecordData>? agentRechargeRecordList,
      AgentData? agentItem,
      SalePointData? salePointItem,
      String? phone,
      String? Amount,
      String? type,
      String? agent,
      bool? isMore,
      int? page}) {
    return ShipmentState(
        salePointList: salePointList ?? this.salePointList,
        agentList: agentList ?? this.agentList,
        agentRechargeRecordList:
            agentRechargeRecordList ?? this.agentRechargeRecordList,
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
