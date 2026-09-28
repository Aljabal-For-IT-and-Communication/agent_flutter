import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  // Ignore responses from requests superseded by a refresh or filter change.
  int recordsRequestVersion = 0;
  int filterVersion = 0;
  bool recordsLoading = false;
  bool exporting = false;

  void invalidateFilters() {
    recordsRequestVersion++;
    filterVersion++;
    recordsLoading = false;
  }

  ShipmentBloc() : super(const ShipmentState()) {
    on<ReportDatesChanged>((event, emit) {
      invalidateFilters();
      emit(state.copyWith(
          startDate: event.startDate,
          endDate: event.endDate,
          agentRechargeRecordList: [],
          totalAmount: '',
          hasMore: true,
          isMore: false,
          isLoading: false));
    });
    on<ReportResultChanged>((event, emit) {
      if (event.version != recordsRequestVersion) return;
      emit(state.copyWith(
          agentRechargeRecordList: event.records,
          totalAmount: event.totalAmount,
          hasMore: event.hasMore,
          isMore: false,
          isLoading: false));
    });
    on<ReportLoadingChanged>((event, emit) {
      if (event.version == recordsRequestVersion) {
        emit(state.copyWith(isLoading: event.loading, isMore: false));
      }
    });
    on<ReportPrintingChanged>(
        (event, emit) => emit(state.copyWith(isPrinting: event.printing)));
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
    if (state.agentItem == event.agentItem) return;
    invalidateFilters();
    emit(state.copyWith(
        agentItem: event.agentItem,
        clearAgentItem: event.agentItem == null,
        agentRechargeRecordList: [],
        totalAmount: '',
        hasMore: true,
        isMore: false,
        isLoading: false));
  }

  void _onSalePointItemChanged(
    SalePointItemChanged event,
    Emitter<ShipmentState> emit,
  ) {
    if (state.salePointItem == event.salePointItem) return;
    invalidateFilters();
    emit(state.copyWith(
        salePointItem: event.salePointItem,
        clearSalePointItem: event.salePointItem == null,
        agentRechargeRecordList: [],
        totalAmount: '',
        hasMore: true,
        isMore: false,
        isLoading: false));
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
    emit(
        state.copyWith(agentRechargeRecordList: event.agentRechargeRecordList));
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
    if (state.agent == event.agent) return;
    invalidateFilters();
    emit(state.copyWith(
        agent: event.agent,
        agentRechargeRecordList: [],
        totalAmount: '',
        hasMore: true,
        isMore: false,
        isLoading: false));
  }
}
