import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class TransferBalanceBloc
    extends Bloc<TransferBalanceEvent, TransferBalanceState> {
  TransferBalanceBloc() : super(const TransferBalanceState()) {
    on<PageChanged>(_onPageChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<TypeChanged>(_onTypeChanged);
    on<AgentChanged>(_onAgentChanged);
    on<SalePointChanged>(_onSalePointChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SalePointItemChanged>(_onSalePointItemChanged);
    on<AgentItemChanged>(_onAgentItemChanged);
    on<AmountChanged>(_onAmountChanged);
    on<UserProfileChanged>(_onUserProfileChanged);
    on<RechargeTypesChanged>(_onRechargeTypesChanged);
    on<RechargeTypeSelected>(_onRechargeTypeSelected);
    on<ResetTransferBalance>(_onReset);
  }

  void _onUserProfileChanged(
    UserProfileChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(userProfile: event.userProfile));
  }

  void _onAgentItemChanged(
    AgentItemChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(agentItem: event.agentItem));
  }

  void _onSalePointItemChanged(
    SalePointItemChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(salePointItem: event.salePointItem));
  }

  void _onSalePointChanged(
    SalePointChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(salePointList: event.salePointList));
  }

  void _onAgentListChanged(
    AgentListChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(agentList: event.agentList));
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }

  void _onPhoneChanged(
    PhoneChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(Amount: event.Amount));
  }

  void _onTypeChanged(
    TypeChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    // reset selected recharge type when type changes
    emit(state.copyWith(type: event.type, rechargeTypeId: null));
  }

  void _onAgentChanged(
    AgentChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    // reset selected recharge type when agent changes
    emit(state.copyWith(agent: event.agent, rechargeTypeId: null));
  }

  void _onRechargeTypesChanged(
    RechargeTypesChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(rechargeTypes: event.rechargeTypes));
  }

  void _onRechargeTypeSelected(
    RechargeTypeSelected event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(rechargeTypeId: event.rechargeTypeId));
  }

  void _onReset(
    ResetTransferBalance event,
    Emitter<TransferBalanceState> emit,
  ) {
    // Reset to initial defaults
    emit(const TransferBalanceState());
  }
}
