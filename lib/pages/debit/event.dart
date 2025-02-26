part of 'bloc.dart';

abstract class DebitEvent {
  const DebitEvent();
}
class SalePointChanged extends DebitEvent {
  const SalePointChanged(this.salePointList);

  final List<SalePointData> salePointList;
}

class AgentListChanged extends DebitEvent {
  const AgentListChanged(this.agentList);

  final List<AgentData> agentList;
}

class AgentItemChanged extends DebitEvent {
  const AgentItemChanged(this.agentItem);

  final AgentData? agentItem;
}

class SalePointItemChanged extends DebitEvent {
  const SalePointItemChanged(this.salePointItem);

  final SalePointData? salePointItem;
}

class IsShowChanged extends DebitEvent {
  const IsShowChanged(this.isShow);

  final bool isShow;
}


class PhoneChanged extends DebitEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class AmountChanged extends DebitEvent {
  const AmountChanged(this.Amount);
  final String Amount;
}


class TypeChanged extends DebitEvent {
  const TypeChanged(this.type);
  final String type;
}

class AgentChanged extends DebitEvent {
  const AgentChanged(this.agent);
  final String agent;
}