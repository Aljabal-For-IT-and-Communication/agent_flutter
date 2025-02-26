import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  ShipmentBloc() : super(const ShipmentState()) {

    on<PageChanged>(_onPageChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<TypeChanged>(_onTypeChanged);
    on<AgentChanged>(_onAgentChanged);
    on<SalePointChanged>(_onSalePointChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SalePointItemChanged>(_onSalePointItemChanged);
    on<AgentItemChanged>(_onAgentItemChanged);
    on<AmountChanged>(_onAmountChanged);
    on<AgentRechargeRecordChanged>(_onAgentRechargeRecordChanged);
    on<IsMoreChanged>(_onIsMoreChanged);

  }


  void _onIsMoreChanged(
      IsMoreChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(isMore: event.isMore));
  }

  void _onAgentItemChanged(
      AgentItemChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(agentItem: event.agentItem));
  }

  void _onSalePointItemChanged(
      SalePointItemChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(salePointItem: event.salePointItem));
  }

  void _onSalePointChanged(
      SalePointChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(salePointList: event.salePointList));
  }

  void _onAgentListChanged(
      AgentListChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(agentList: event.agentList));
  }

  void _onAgentRechargeRecordChanged(
      AgentRechargeRecordChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(agentRechargeRecordList: event.agentRechargeRecordList));
  }

  void _onPageChanged(
      PageChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

  void _onPhoneChanged(
      PhoneChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onAmountChanged(
      AmountChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(Amount: event.Amount));
  }

  void _onTypeChanged(
      TypeChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(type: event.type));
  }
  void _onAgentChanged(
      AgentChanged event,
      Emitter<ShipmentState> emit,
      ) {
    emit(state.copyWith(agent: event.agent));
  }

}
