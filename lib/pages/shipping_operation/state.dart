part of 'bloc.dart';

class ShippingOperationState {
  const ShippingOperationState({
    this.shippingOperationList = const <ShippingOperationData>[],
    this.page = 0,
    this.isMore = false,
    this.day = "",
  });

  final int page;
  final bool isMore;
  final String day;
  final List<ShippingOperationData> shippingOperationList;

  ShippingOperationState copyWith({
    List<ShippingOperationData>? shippingOperationList,
    String? day,
    int? page,
    bool? isMore,
  }) {
    return ShippingOperationState(
      shippingOperationList: shippingOperationList ?? this.shippingOperationList,
      day: day ?? this.day,
      page:page??this.page,
      isMore:isMore??this.isMore,
    );
  }
}
