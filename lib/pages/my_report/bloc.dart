import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class MyReportBloc extends Bloc<MyReportEvent, MyReportState> {
  MyReportBloc() : super(const MyReportState()) {

    on<PageChanged>(_onPageChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<TypeChanged>(_onTypeChanged);
    on<AgentChanged>(_onAgentChanged);
    on<SalePointChanged>(_onSalePointChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SalePointItemChanged>(_onSalePointItemChanged);
    on<AgentItemChanged>(_onAgentItemChanged);
    on<AmountChanged>(_onAmountChanged);
    on<SuperRechargeRecordChanged>(_onSuperRechargeRecordChanged);
    on<ChildRechargeRecordChanged>(_onChildRechargeRecordChanged);
    on<IsMoreChanged>(_onIsMoreChanged);

  }


  void _onIsMoreChanged(
      IsMoreChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(isMore: event.isMore));
  }

  void _onAgentItemChanged(
      AgentItemChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(agentItem: event.agentItem));
  }

  void _onSalePointItemChanged(
      SalePointItemChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(salePointItem: event.salePointItem));
  }

  void _onSalePointChanged(
      SalePointChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(salePointList: event.salePointList));
  }

  void _onAgentListChanged(
      AgentListChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(agentList: event.agentList));
  }

  void _onSuperRechargeRecordChanged(
      SuperRechargeRecordChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(superRechargeRecordList: event.superRechargeRecordList));
  }

  void _onChildRechargeRecordChanged(
      ChildRechargeRecordChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(childRechargeRecordList: event.childRechargeRecordList));
  }

  void _onPageChanged(
      PageChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

  void _onPhoneChanged(
      PhoneChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onAmountChanged(
      AmountChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(Amount: event.Amount));
  }

  void _onTypeChanged(
      TypeChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(type: event.type));
  }
  void _onAgentChanged(
      AgentChanged event,
      Emitter<MyReportState> emit,
      ) {
    emit(state.copyWith(agent: event.agent));
  }

}
