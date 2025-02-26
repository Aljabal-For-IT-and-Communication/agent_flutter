import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class AccountStatementBloc extends Bloc<AccountStatementEvent, AccountStatementState> {
  AccountStatementBloc() : super(const AccountStatementState()) {
    on<PageChanged>(_onPageChanged);
    on<StartDateChanged>(_onStartDateChanged);
    on<EndDateChanged>(_onEndDateChanged);
    on<AccountStatementChanged>(_onAccountStatementChanged);
  }

  void _onAccountStatementChanged(
      AccountStatementChanged event,
      Emitter<AccountStatementState> emit,
      ) {
    emit(state.copyWith(accountStatement: event.accountStatement));
  }

  void _onPageChanged(
      PageChanged event,
      Emitter<AccountStatementState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

  void _onStartDateChanged(
      StartDateChanged event,
      Emitter<AccountStatementState> emit,
      ) {
    emit(state.copyWith(startDate: event.startDate));
  }

  void _onEndDateChanged(
      EndDateChanged event,
      Emitter<AccountStatementState> emit,
      ) {
    emit(state.copyWith(endDate: event.endDate));
  }

}
