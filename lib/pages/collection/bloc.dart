import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc() : super(const CollectionState()) {
    on<PageChanged>(_onPageChanged);
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<CollectionState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }
}
