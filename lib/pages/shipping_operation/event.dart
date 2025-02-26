part of 'bloc.dart';

abstract class ShippingOperationEvent {
  const ShippingOperationEvent();
}
class ShippingOperationChanged extends ShippingOperationEvent {
  const ShippingOperationChanged(this.shippingOperationList);

  final List<ShippingOperationData> shippingOperationList;
}

class PageChanged extends ShippingOperationEvent {
  const PageChanged(this.page);

  final int page;
}

class IsMoreChanged extends ShippingOperationEvent {
  const IsMoreChanged(this.isMore);

  final bool isMore;
}

class DayChanged extends ShippingOperationEvent {
  const DayChanged(this.day);

  final String day;
}