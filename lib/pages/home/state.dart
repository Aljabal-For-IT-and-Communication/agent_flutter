part of 'bloc.dart';

class HomeState {
  const HomeState({
    this.shippingOperationList = const <ShippingOperationData>[],
    this.pendingCollections = const <PendingCollectionData>[],
    this.page = 0,
    this.userProfile,
  });

  final List<ShippingOperationData> shippingOperationList;
  final List<PendingCollectionData> pendingCollections;
  final int page;
  final UserItem? userProfile;

  HomeState copyWith({
    List<ShippingOperationData>? shippingOperationList,
    List<PendingCollectionData>? pendingCollections,
    int? page,
    UserItem? userProfile,
  }) {
    return HomeState(
      shippingOperationList:
          shippingOperationList ?? this.shippingOperationList,
      pendingCollections: pendingCollections ?? this.pendingCollections,
      page: page ?? this.page,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
