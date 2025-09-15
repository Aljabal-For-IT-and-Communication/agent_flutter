import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class SalePointBloc extends Bloc<SalePointEvent, SalePointState> {
  SalePointBloc() : super(const SalePointState()) {
    on<SalePointChanged>(_onSalePointChanged);
    on<PageChanged>(_onPageChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SetEditingSalePoint>(_onSetEditingSalePoint);
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

  void _onSetEditingSalePoint(
    SetEditingSalePoint event,
    Emitter<SalePointState> emit,
  ) {
    // Explicitly set editingSalePointId, allowing null to clear editing.
    emit(SalePointState(
      salePointList: state.salePointList,
      agentList: state.agentList,
      page: state.page,
      editingSalePointId: event.salePointId,
    ));
  }
}
