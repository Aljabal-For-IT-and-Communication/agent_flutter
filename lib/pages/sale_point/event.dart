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

class SalePointSearchChanged extends SalePointEvent {
  const SalePointSearchChanged(this.query);
  final String query;
}

class AgentSearchChanged extends SalePointEvent {
  const AgentSearchChanged(this.query);
  final String query;
}

class ToggleSalePointSort extends SalePointEvent {
  const ToggleSalePointSort(this.field);
  final SortField field;
}

class ToggleAgentSort extends SalePointEvent {
  const ToggleAgentSort(this.field);
  final SortField field;
}

class SalePointRemoved extends SalePointEvent {
  const SalePointRemoved(this.salePointId);
  final int? salePointId;
}
