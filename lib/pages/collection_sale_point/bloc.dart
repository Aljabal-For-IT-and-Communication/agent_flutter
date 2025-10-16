import 'package:app/common/entities/entities.dart';
import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class CollectionSalePointBloc
    extends Bloc<CollectionSalePointEvent, CollectionSalePointState> {
  CollectionSalePointBloc() : super(const CollectionSalePointState()) {
    on<PageChanged>(_onPageChanged);
    on<StartDateChanged>(_onStartDateChanged);
    on<EndDateChanged>(_onEndDateChanged);
    on<AmountChanged>(_onAmountChanged);
    on<AgentCollectRecordListChanged>(_onAgentCollectRecordListChanged);
    on<IsMoreChanged>(_onIsMoreChanged);
  }

  void _onIsMoreChanged(
    IsMoreChanged event,
    Emitter<CollectionSalePointState> emit,
  ) {
    emit(state.copyWith(isMore: event.isMore));
  }

  void _onAgentCollectRecordListChanged(
    AgentCollectRecordListChanged event,
    Emitter<CollectionSalePointState> emit,
  ) {
    emit(state.copyWith(agentCollectRecordList: event.agentCollectRecordList));
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<CollectionSalePointState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }

  void _onStartDateChanged(
    StartDateChanged event,
    Emitter<CollectionSalePointState> emit,
  ) {
    emit(state.copyWith(startDate: event.startDate));
  }

  void _onEndDateChanged(
    EndDateChanged event,
    Emitter<CollectionSalePointState> emit,
  ) {
    emit(state.copyWith(endDate: event.endDate));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<CollectionSalePointState> emit,
  ) {
    emit(state.copyWith(amount: event.amount));
  }
}
