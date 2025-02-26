import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class ShippingOperationBloc extends Bloc<ShippingOperationEvent, ShippingOperationState> {
  ShippingOperationBloc() : super(const ShippingOperationState()) {
    on<ShippingOperationChanged>(_onShippingOperationChanged);
    on<PageChanged>(_onPageChanged);
    on<DayChanged>(_onDayChanged);
    on<IsMoreChanged>(_onIsMoreChanged);
  }

  void _onShippingOperationChanged(
      ShippingOperationChanged event,
      Emitter<ShippingOperationState> emit,
      ) {
    emit(state.copyWith(shippingOperationList: event.shippingOperationList));
  }

  void _onPageChanged(
      PageChanged event,
      Emitter<ShippingOperationState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

  void _onIsMoreChanged(
      IsMoreChanged event,
      Emitter<ShippingOperationState> emit,
      ) {
    emit(state.copyWith(isMore: event.isMore));
  }

  void _onDayChanged(
      DayChanged event,
      Emitter<ShippingOperationState> emit,
      ) {
    emit(state.copyWith(day: event.day));
  }

}
