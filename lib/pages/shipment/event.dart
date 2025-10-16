part of 'bloc.dart';

abstract class ShipmentEvent {
  const ShipmentEvent();
}

class SalePointChanged extends ShipmentEvent {
  const SalePointChanged(this.salePointList);

  final List<SalePointData> salePointList;
}

class IsMoreChanged extends ShipmentEvent {
  const IsMoreChanged(this.isMore);

  final bool isMore;
}

class AgentListChanged extends ShipmentEvent {
  const AgentListChanged(this.agentList);

  final List<AgentData> agentList;
}

class AgentRechargeRecordChanged extends ShipmentEvent {
  const AgentRechargeRecordChanged(this.agentRechargeRecordList);

  final List<AgentRechargeRecordData> agentRechargeRecordList;
}

class AgentItemChanged extends ShipmentEvent {
  const AgentItemChanged(this.agentItem);

  final AgentData? agentItem;
}

class SalePointItemChanged extends ShipmentEvent {
  const SalePointItemChanged(this.salePointItem);

  final SalePointData? salePointItem;
}

class PageChanged extends ShipmentEvent {
  const PageChanged(this.page);

  final int page;
}

class PhoneChanged extends ShipmentEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class AmountChanged extends ShipmentEvent {
  const AmountChanged(this.Amount);
  final String Amount;
}

class TypeChanged extends ShipmentEvent {
  const TypeChanged(this.type);
  final String type;
}

class AgentChanged extends ShipmentEvent {
  const AgentChanged(this.agent);
  final String agent;
}
