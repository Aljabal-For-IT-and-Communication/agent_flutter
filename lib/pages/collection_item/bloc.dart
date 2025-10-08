import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class CollectionItemBloc
    extends Bloc<CollectionItemEvent, CollectionItemState> {
  CollectionItemBloc() : super(const CollectionItemState()) {
    on<IsShowChanged>(_onIsShowChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<TypeChanged>(_onTypeChanged);
    on<AgentChanged>(_onAgentChanged);
    on<SalePointChanged>(_onSalePointChanged);
    on<AgentListChanged>(_onAgentListChanged);
    on<SalePointItemChanged>(_onSalePointItemChanged);
    on<AgentItemChanged>(_onAgentItemChanged);
    on<AmountChanged>(_onAmountChanged);
    on<CollectTypesChanged>(_onCollectTypesChanged);
    on<CollectTypeSelected>(_onCollectTypeSelected);
    on<ResetCollectionItem>(_onReset);
  }

  void _onAgentItemChanged(
    AgentItemChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(agentItem: event.agentItem));
  }

  void _onSalePointItemChanged(
    SalePointItemChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(salePointItem: event.salePointItem));
  }

  void _onSalePointChanged(
    SalePointChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(salePointList: event.salePointList));
  }

  void _onAgentListChanged(
    AgentListChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(agentList: event.agentList));
  }

  void _onIsShowChanged(
    IsShowChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(isShow: event.isShow));
  }

  void _onPhoneChanged(
    PhoneChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(Amount: event.Amount));
  }

  void _onTypeChanged(
    TypeChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(type: event.type));
  }

  void _onAgentChanged(
    AgentChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(agent: event.agent, collectTypeId: null));
  }

  void _onCollectTypesChanged(
    CollectTypesChanged event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(collectTypes: event.collectTypes));
  }

  void _onCollectTypeSelected(
    CollectTypeSelected event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(state.copyWith(collectTypeId: event.collectTypeId));
  }

  void _onReset(
    ResetCollectionItem event,
    Emitter<CollectionItemState> emit,
  ) {
    emit(const CollectionItemState());
  }
}
