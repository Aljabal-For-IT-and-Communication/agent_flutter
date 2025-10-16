part of 'bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class UserProfileChanged extends HomeEvent {
  const UserProfileChanged(this.userProfile);

  final UserItem userProfile;
}

class ShippingOperationChanged extends HomeEvent {
  const ShippingOperationChanged(this.shippingOperationList);

  final List<ShippingOperationData> shippingOperationList;
}

class PendingCollectionsChanged extends HomeEvent {
  const PendingCollectionsChanged(this.pendingCollections);

  final List<PendingCollectionData> pendingCollections;
}

class PageChanged extends HomeEvent {
  const PageChanged(this.page);

  final int page;
}

class PendingTransactionsChanged extends HomeEvent {
  const PendingTransactionsChanged(this.pendingTransactions);

  final List<PendingTransactionData> pendingTransactions;
}
