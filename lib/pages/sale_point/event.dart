part of 'bloc.dart';

abstract class SalePointEvent {
  const SalePointEvent();
}

class SalePointChanged extends SalePointEvent {
  const SalePointChanged(this.salePointList);

  final List<SalePointData> salePointList;
}

class PageChanged extends SalePointEvent {
  const PageChanged(this.page);

  final int page;
}

class AgentListChanged extends SalePointEvent {
  const AgentListChanged(this.agentList);

  final List<AgentData> agentList;
}

class SetEditingSalePoint extends SalePointEvent {
  const SetEditingSalePoint(this.salePointId);

  final int? salePointId; // null to cancel editing
}
