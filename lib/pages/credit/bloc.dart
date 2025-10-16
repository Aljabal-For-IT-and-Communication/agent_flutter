import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  CreditBloc() : super(const CreditState()) {
    on<PageChanged>(_onPageChanged);
    on<AmountChanged>(_onAmountChanged);
    on<UserProfileChanged>(_onUserProfileChanged);
  }

  void _onUserProfileChanged(
    UserProfileChanged event,
    Emitter<CreditState> emit,
  ) {
    emit(state.copyWith(userProfile: event.userProfile));
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<CreditState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<CreditState> emit,
  ) {
    emit(state.copyWith(Amount: event.Amount));
  }
}
