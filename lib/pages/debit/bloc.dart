import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class DebitBloc extends Bloc<DebitEvent, DebitState> {
  DebitBloc() : super(const DebitState()) {
    on<IsShowChanged>(_onIsShowChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<TypeChanged>(_onTypeChanged);
    on<AgentChanged>(_onAgentChanged);
    on<SalePointChanged>(_onSalePointChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SalePointItemChanged>(_onSalePointItemChanged);
    on<AgentItemChanged>(_onAgentItemChanged);
    on<AmountChanged>(_onAmountChanged);
  }

  void _onAgentItemChanged(
      AgentItemChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(agentItem: event.agentItem));
  }

  void _onSalePointItemChanged(
      SalePointItemChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(salePointItem: event.salePointItem));
  }

  void _onSalePointChanged(
      SalePointChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(salePointList: event.salePointList));
  }

  void _onAgentListChanged(
      AgentListChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(agentList: event.agentList));
  }

  void _onIsShowChanged(
      IsShowChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(isShow: event.isShow));
  }

  void _onPhoneChanged(
      PhoneChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onAmountChanged(
      AmountChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(Amount: event.Amount));
  }

  void _onTypeChanged(
      TypeChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(type: event.type));
  }
  void _onAgentChanged(
      AgentChanged event,
      Emitter<DebitState> emit,
      ) {
    emit(state.copyWith(agent: event.agent));
  }

}
