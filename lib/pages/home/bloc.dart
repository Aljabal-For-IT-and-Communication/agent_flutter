import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ShippingOperationChanged>(_onShippingOperationChanged);
    on<PendingTransactionsChanged>(_onPendingTransactionsChanged);
    on<PageChanged>(_onPageChanged);
    on<UserProfileChanged>(_onUserProfileChanged);
  }

  void _onUserProfileChanged(
    UserProfileChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(userProfile: event.userProfile));
  }

  void _onShippingOperationChanged(
    ShippingOperationChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(shippingOperationList: event.shippingOperationList));
  }

  void _onPendingTransactionsChanged(
    PendingTransactionsChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(pendingTransactions: event.pendingTransactions));
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }
}
