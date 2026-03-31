part of 'bloc.dart';

abstract class CollectionItemEvent {
  const CollectionItemEvent();
}

class SalePointChanged extends CollectionItemEvent {
  const SalePointChanged(this.salePointList);

  final List<SalePointData> salePointList;
}

class AgentListChanged extends CollectionItemEvent {
  const AgentListChanged(this.agentList);

  final List<AgentData> agentList;
}

class AgentItemChanged extends CollectionItemEvent {
  const AgentItemChanged(this.agentItem);

  final AgentData? agentItem;
}

class SalePointItemChanged extends CollectionItemEvent {
  const SalePointItemChanged(this.salePointItem);

  final SalePointData? salePointItem;
}

class IsShowChanged extends CollectionItemEvent {
  const IsShowChanged(this.isShow);

  final bool isShow;
}

class PhoneChanged extends CollectionItemEvent {
  const PhoneChanged(this.phone);
  final String phone;
}

class AmountChanged extends CollectionItemEvent {
  const AmountChanged(this.Amount);
  final String Amount;
}

class TypeChanged extends CollectionItemEvent {
  const TypeChanged(this.type);
  final String type;
}

class AgentChanged extends CollectionItemEvent {
  const AgentChanged(this.agent);
  final String agent;
}

class CollectTypesChanged extends CollectionItemEvent {
  const CollectTypesChanged(this.collectTypes);
  final List<CollectTypeData> collectTypes;
}

class CollectTypeSelected extends CollectionItemEvent {
  const CollectTypeSelected(this.collectTypeId);
  final int? collectTypeId;
}

class ResetCollectionItem extends CollectionItemEvent {
  const ResetCollectionItem();
}

class ValidationFilePicked extends CollectionItemEvent {
  const ValidationFilePicked(this.path, this.name);

  final String path;
  final String name;
}

class ValidationFileCleared extends CollectionItemEvent {
  const ValidationFileCleared();
}

class LockedModeSet extends CollectionItemEvent {
  const LockedModeSet({
    required this.salePointItem,
  });
  final SalePointData salePointItem;
}
