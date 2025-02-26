import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  RevenueBloc() : super(const RevenueState()) {

    on<PageChanged>(_onPageChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<TypeChanged>(_onTypeChanged);
    on<AgentChanged>(_onAgentChanged);
    on<SalePointChanged>(_onSalePointChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SalePointItemChanged>(_onSalePointItemChanged);
    on<AgentItemChanged>(_onAgentItemChanged);
    on<AmountChanged>(_onAmountChanged);
    on<AgentCollectRecordListChanged>(_onAgentCollectRecordListChanged);
    on<IsMoreChanged>(_onIsMoreChanged);

  }


  void _onIsMoreChanged(
      IsMoreChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(isMore: event.isMore));
  }

  void _onAgentItemChanged(
      AgentItemChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(agentItem: event.agentItem));
  }

  void _onAgentCollectRecordListChanged(
      AgentCollectRecordListChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(agentCollectRecordList: event.agentCollectRecordList));
  }

  void _onSalePointItemChanged(
      SalePointItemChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(salePointItem: event.salePointItem));
  }

  void _onSalePointChanged(
      SalePointChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(salePointList: event.salePointList));
  }

  void _onAgentListChanged(
      AgentListChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(agentList: event.agentList));
  }

  void _onPageChanged(
      PageChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

  void _onPhoneChanged(
      PhoneChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onAmountChanged(
      AmountChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(Amount: event.Amount));
  }

  void _onTypeChanged(
      TypeChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(type: event.type));
  }
  void _onAgentChanged(
      AgentChanged event,
      Emitter<RevenueState> emit,
      ) {
    emit(state.copyWith(agent: event.agent));
  }

}
