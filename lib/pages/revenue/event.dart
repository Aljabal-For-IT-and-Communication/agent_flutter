part of 'bloc.dart';

abstract class RevenueEvent {
  const RevenueEvent();
}

class SalePointChanged extends RevenueEvent {
  const SalePointChanged(this.salePointList);

  final List<SalePointData> salePointList;
}

class AgentListChanged extends RevenueEvent {
  const AgentListChanged(this.agentList);

  final List<AgentData> agentList;
}

class IsMoreChanged extends RevenueEvent {
  const IsMoreChanged(this.isMore);

  final bool isMore;
}

class AgentCollectRecordListChanged extends RevenueEvent {
  const AgentCollectRecordListChanged(this.agentCollectRecordList);

  final List<AgentCollectRecordData> agentCollectRecordList;
}

class AgentItemChanged extends RevenueEvent {
  const AgentItemChanged(this.agentItem);

  final AgentData? agentItem;
}

class SalePointItemChanged extends RevenueEvent {
  const SalePointItemChanged(this.salePointItem);

  final SalePointData? salePointItem;
}

class PageChanged extends RevenueEvent {
  const PageChanged(this.page);

  final int page;
}

class PhoneChanged extends RevenueEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class AmountChanged extends RevenueEvent {
  const AmountChanged(this.Amount);
  final String Amount;
}

class TypeChanged extends RevenueEvent {
  const TypeChanged(this.type);
  final String type;
}

class AgentChanged extends RevenueEvent {
  const AgentChanged(this.agent);
  final String agent;
}
