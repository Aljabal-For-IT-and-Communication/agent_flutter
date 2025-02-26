part of 'bloc.dart';

class CollectionItemState {
  const CollectionItemState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.agentItem,
    this.salePointItem,
    this.phone = "",
    this.Amount = "",
    this.type = "recharge",
    this.agent = "Agent",
    this.isShow = false,
  });

  final String phone;
  final String Amount;
  final String type;
  final String agent;
  final bool isShow;
  final List<SalePointData> salePointList;
  final List<AgentData> agentList;
  final AgentData? agentItem;
  final SalePointData? salePointItem;

  CollectionItemState copyWith(
      {List<SalePointData>? salePointList,
      List<AgentData>? agentList,
      AgentData? agentItem,
      SalePointData? salePointItem,
      String? phone,
      String? Amount,
      String? type,
      String? agent,
      bool? isShow}) {
    return CollectionItemState(
        salePointList: salePointList ?? this.salePointList,
        agentList: agentList ?? this.agentList,
        phone: phone ?? this.phone,
        Amount: Amount ?? this.Amount,
        type: type ?? this.type,
        agent: agent ?? this.agent,
        agentItem: agentItem ?? this.agentItem,
        salePointItem: salePointItem ?? this.salePointItem,
        isShow: isShow ?? this.isShow);
  }
}
