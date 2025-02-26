part of 'bloc.dart';

class HomeState {
  const HomeState({
    this.shippingOperationList = const <ShippingOperationData>[],
    this.page = 0,
    this.userProfile,
  });

  final List<ShippingOperationData> shippingOperationList;
  final int page;
  final UserItem? userProfile;

  HomeState copyWith({
    List<ShippingOperationData>? shippingOperationList,
    int? page,
    UserItem? userProfile,
  }) {
    return HomeState(
        shippingOperationList: shippingOperationList ?? this.shippingOperationList,
        page:page??this.page,
        userProfile: userProfile ?? this.userProfile,
    );
  }
}
