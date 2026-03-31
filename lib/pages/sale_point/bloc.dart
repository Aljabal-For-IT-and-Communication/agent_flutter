import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class SalePointBloc extends Bloc<SalePointEvent, SalePointState> {
  SalePointBloc() : super(const SalePointState()) {
    on<SalePointChanged>(_onSalePointChanged);
    on<PageChanged>(_onPageChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SalePointSearchChanged>(_onSalePointSearchChanged);
    on<AgentSearchChanged>(_onAgentSearchChanged);
    on<ToggleSalePointSort>(_onToggleSalePointSort);
    on<ToggleAgentSort>(_onToggleAgentSort);
    on<SalePointRemoved>(_onSalePointRemoved);
    on<SalePointItemUpdated>(_onSalePointItemUpdated);
  }
  void _onSalePointChanged(
    SalePointChanged event,
    Emitter<SalePointState> emit,
  ) {
    emit(state.copyWith(salePointList: event.salePointList));
  }

  void _onAgentListChanged(
    AgentListChanged event,
    Emitter<SalePointState> emit,
  ) {
    emit(state.copyWith(agentList: event.agentList));
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<SalePointState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }

  void _onSalePointSearchChanged(
    SalePointSearchChanged event,
    Emitter<SalePointState> emit,
  ) {
    emit(state.copyWith(salePointSearch: event.query));
  }

  void _onAgentSearchChanged(
    AgentSearchChanged event,
    Emitter<SalePointState> emit,
  ) {
    emit(state.copyWith(agentSearch: event.query));
  }

  void _onToggleSalePointSort(
    ToggleSalePointSort event,
    Emitter<SalePointState> emit,
  ) {
    final sameField = state.salePointSortField == event.field;
    emit(state.copyWith(
      salePointSortField: event.field,
      salePointSortAsc: sameField ? !state.salePointSortAsc : false,
    ));
  }

  void _onToggleAgentSort(
    ToggleAgentSort event,
    Emitter<SalePointState> emit,
  ) {
    final sameField = state.agentSortField == event.field;
    emit(state.copyWith(
      agentSortField: event.field,
      agentSortAsc: sameField ? !state.agentSortAsc : false,
    ));
  }

  void _onSalePointRemoved(
    SalePointRemoved event,
    Emitter<SalePointState> emit,
  ) {
    final updated = state.salePointList
        .where((sp) => sp.id != event.salePointId)
        .toList();
    emit(state.copyWith(salePointList: updated));
  }

  void _onSalePointItemUpdated(
    SalePointItemUpdated event,
    Emitter<SalePointState> emit,
  ) {
    final updated = state.salePointList.map((sp) {
      if (sp.id == event.updatedItem.id) {
        return event.updatedItem;
      }
      return sp;
    }).toList();
    emit(state.copyWith(salePointList: updated));
  }
}
