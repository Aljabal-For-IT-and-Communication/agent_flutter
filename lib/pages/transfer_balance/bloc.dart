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
    on<ValidationFilePicked>(_onValidationFilePicked);
    on<ValidationFileCleared>(_onValidationFileCleared);
    on<LockedModeSet>(_onLockedModeSet);
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
    emit(state.copyWith(
        type: event.type, rechargeTypeId: null, clearValidationFile: true));
  }

  void _onAgentChanged(
    AgentChanged event,
    Emitter<TransferBalanceState> emit,
  ) {
    // reset selected recharge type when agent changes
    emit(state.copyWith(
        agent: event.agent, rechargeTypeId: null, clearValidationFile: true));
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
    // Clear any previously selected file when type changes
    emit(state.copyWith(
        rechargeTypeId: event.rechargeTypeId, clearValidationFile: true));
  }

  void _onReset(
    ResetTransferBalance event,
    Emitter<TransferBalanceState> emit,
  ) {
    // Reset to initial defaults, keep userProfile, and bump formVersion to refresh inputs
    emit(TransferBalanceState(
      userProfile: state.userProfile,
      formVersion: state.formVersion + 1,
    ));
  }

  void _onValidationFilePicked(
    ValidationFilePicked event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(
        validationFilePath: event.path, validationFileName: event.name));
  }

  void _onValidationFileCleared(
    ValidationFileCleared event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(clearValidationFile: true));
  }

  void _onLockedModeSet(
    LockedModeSet event,
    Emitter<TransferBalanceState> emit,
  ) {
    emit(state.copyWith(
      isLocked: true,
      agent: 'SalePoint',
      salePointItem: event.salePointItem,
      salePointList: [event.salePointItem],
      type: event.type,
    ));
  }
}
