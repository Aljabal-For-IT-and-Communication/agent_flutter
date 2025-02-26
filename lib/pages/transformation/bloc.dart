import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class TransformationBloc extends Bloc<TransformationEvent, TransformationState> {
  TransformationBloc() : super(const TransformationState()) {

    on<PageChanged>(_onPageChanged);
  }

  void _onPageChanged(
      PageChanged event,
      Emitter<TransformationState> emit,
      ) {
    emit(state.copyWith(page: event.page));
  }

}
