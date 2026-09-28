import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
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

  RevenueBloc() : super(const RevenueState()) {
    on<ReportDatesChanged>((event, emit) {
      invalidateFilters();
      emit(state.copyWith(
          startDate: event.startDate,
          endDate: event.endDate,
          agentCollectRecordList: [],
          totalAmount: '',
          hasMore: true,
          isMore: false,
          isLoading: false));
    });
    on<ReportResultChanged>((event, emit) {
      if (event.version != recordsRequestVersion) return;
      emit(state.copyWith(
          agentCollectRecordList: event.records,
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
    if (state.agentItem == event.agentItem) return;
    invalidateFilters();
    emit(state.copyWith(
        agentItem: event.agentItem,
        clearAgentItem: event.agentItem == null,
        agentCollectRecordList: [],
        totalAmount: '',
        hasMore: true,
        isMore: false,
        isLoading: false));
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
    if (state.salePointItem == event.salePointItem) return;
    invalidateFilters();
    emit(state.copyWith(
        salePointItem: event.salePointItem,
        clearSalePointItem: event.salePointItem == null,
        agentCollectRecordList: [],
        totalAmount: '',
        hasMore: true,
        isMore: false,
        isLoading: false));
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
    if (state.agent == event.agent) return;
    invalidateFilters();
    emit(state.copyWith(
        agent: event.agent,
        agentCollectRecordList: [],
        totalAmount: '',
        hasMore: true,
        isMore: false,
        isLoading: false));
  }
}
