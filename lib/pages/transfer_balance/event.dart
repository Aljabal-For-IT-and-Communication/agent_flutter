part of 'bloc.dart';

abstract class TransferBalanceEvent {
  const TransferBalanceEvent();
}

class UserProfileChanged extends TransferBalanceEvent {
  const UserProfileChanged(this.userProfile);

  final UserItem userProfile;
}

class SalePointChanged extends TransferBalanceEvent {
  const SalePointChanged(this.salePointList);

  final List<SalePointData> salePointList;
}

class AgentListChanged extends TransferBalanceEvent {
  const AgentListChanged(this.agentList);

  final List<AgentData> agentList;
}

class AgentItemChanged extends TransferBalanceEvent {
  const AgentItemChanged(this.agentItem);

  final AgentData? agentItem;
}

class SalePointItemChanged extends TransferBalanceEvent {
  const SalePointItemChanged(this.salePointItem);

  final SalePointData? salePointItem;
}

class PageChanged extends TransferBalanceEvent {
  const PageChanged(this.page);

  final int page;
}

class PhoneChanged extends TransferBalanceEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class AmountChanged extends TransferBalanceEvent {
  const AmountChanged(this.Amount);
  final String Amount;
}

class TypeChanged extends TransferBalanceEvent {
  const TypeChanged(this.type);
  final String type;
}

class AgentChanged extends TransferBalanceEvent {
  const AgentChanged(this.agent);
  final String agent;
}

class RechargeTypesChanged extends TransferBalanceEvent {
  const RechargeTypesChanged(this.rechargeTypes);
  final List<RechargeTypeData> rechargeTypes;
}

class RechargeTypeSelected extends TransferBalanceEvent {
  const RechargeTypeSelected(this.rechargeTypeId);
  final int? rechargeTypeId;
}

class ResetTransferBalance extends TransferBalanceEvent {
  const ResetTransferBalance();
}

class ValidationFilePicked extends TransferBalanceEvent {
  const ValidationFilePicked(this.path, this.name);

  final String path;
  final String name;
}

class ValidationFileCleared extends TransferBalanceEvent {
  const ValidationFileCleared();
}
