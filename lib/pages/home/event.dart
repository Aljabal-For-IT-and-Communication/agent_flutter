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

class PageChanged extends HomeEvent {
  const PageChanged(this.page);

  final int page;
}