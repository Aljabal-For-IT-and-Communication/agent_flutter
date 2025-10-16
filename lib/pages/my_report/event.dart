part of 'bloc.dart';

abstract class MyReportEvent {
  const MyReportEvent();
}

class SalePointChanged extends MyReportEvent {
  const SalePointChanged(this.salePointList);

  final List<SalePointData> salePointList;
}

class AgentListChanged extends MyReportEvent {
  const AgentListChanged(this.agentList);

  final List<AgentData> agentList;
}

class IsMoreChanged extends MyReportEvent {
  const IsMoreChanged(this.isMore);

  final bool isMore;
}

class SuperRechargeRecordChanged extends MyReportEvent {
  const SuperRechargeRecordChanged(this.superRechargeRecordList);

  final List<SuperRechargeRecordData> superRechargeRecordList;
}

class ChildRechargeRecordChanged extends MyReportEvent {
  const ChildRechargeRecordChanged(this.childRechargeRecordList);

  final List<ChildRechargeRecordData> childRechargeRecordList;
}

class AgentItemChanged extends MyReportEvent {
  const AgentItemChanged(this.agentItem);

  final AgentData? agentItem;
}

class SalePointItemChanged extends MyReportEvent {
  const SalePointItemChanged(this.salePointItem);

  final SalePointData? salePointItem;
}

class PageChanged extends MyReportEvent {
  const PageChanged(this.page);

  final int page;
}

class PhoneChanged extends MyReportEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class AmountChanged extends MyReportEvent {
  const AmountChanged(this.Amount);
  final String Amount;
}

class TypeChanged extends MyReportEvent {
  const TypeChanged(this.type);
  final String type;
}

class AgentChanged extends MyReportEvent {
  const AgentChanged(this.agent);
  final String agent;
}
