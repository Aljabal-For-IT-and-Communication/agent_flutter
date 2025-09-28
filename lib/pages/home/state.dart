part of 'bloc.dart';

class HomeState {
  const HomeState({
    this.shippingOperationList = const <ShippingOperationData>[],
    this.pendingTransactions = const <PendingTransactionData>[],
    this.page = 0,
    this.userProfile,
  });

  final List<ShippingOperationData> shippingOperationList;
  final List<PendingTransactionData> pendingTransactions;
  final int page;
  final UserItem? userProfile;

  HomeState copyWith({
    List<ShippingOperationData>? shippingOperationList,
    List<PendingTransactionData>? pendingTransactions,
    int? page,
    UserItem? userProfile,
  }) {
    return HomeState(
      shippingOperationList:
          shippingOperationList ?? this.shippingOperationList,
      pendingTransactions: pendingTransactions ?? this.pendingTransactions,
      page: page ?? this.page,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
