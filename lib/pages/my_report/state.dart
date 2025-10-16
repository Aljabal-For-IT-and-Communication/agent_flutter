part of 'bloc.dart';

class MyReportState {
  const MyReportState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.superRechargeRecordList = const <SuperRechargeRecordData>[],
    this.childRechargeRecordList = const <ChildRechargeRecordData>[],
    this.agentItem,
    this.salePointItem,
    this.phone = "",
    this.Amount = "",
    this.type = "recharge",
    this.agent = "shipment report",
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
  final List<SuperRechargeRecordData> superRechargeRecordList;
  final List<ChildRechargeRecordData> childRechargeRecordList;
  final AgentData? agentItem;
  final SalePointData? salePointItem;

  MyReportState copyWith(
      {List<SalePointData>? salePointList,
      List<AgentData>? agentList,
      List<SuperRechargeRecordData>? superRechargeRecordList,
      List<ChildRechargeRecordData>? childRechargeRecordList,
      AgentData? agentItem,
      SalePointData? salePointItem,
      String? phone,
      String? Amount,
      String? type,
      bool? isMore,
      String? agent,
      int? page}) {
    return MyReportState(
        salePointList: salePointList ?? this.salePointList,
        agentList: agentList ?? this.agentList,
        superRechargeRecordList:
            superRechargeRecordList ?? this.superRechargeRecordList,
        childRechargeRecordList:
            childRechargeRecordList ?? this.childRechargeRecordList,
        phone: phone ?? this.phone,
        Amount: Amount ?? this.Amount,
        type: type ?? this.type,
        agent: agent ?? this.agent,
        isMore: isMore ?? this.isMore,
        agentItem: agentItem ?? this.agentItem,
        salePointItem: salePointItem ?? this.salePointItem,
        page: page ?? this.page);
  }
}
