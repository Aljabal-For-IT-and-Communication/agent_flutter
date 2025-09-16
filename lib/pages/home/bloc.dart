import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ShippingOperationChanged>(_onShippingOperationChanged);
    on<PendingCollectionsChanged>(_onPendingCollectionsChanged);
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

  void _onPendingCollectionsChanged(
    PendingCollectionsChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(pendingCollections: event.pendingCollections));
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }
}
