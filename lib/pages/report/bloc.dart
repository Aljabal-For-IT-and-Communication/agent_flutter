import 'package:bloc/bloc.dart';
import 'package:app/common/entities/entities.dart';

part 'event.dart';
part 'state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(const ReportState()) {
    on<PageChanged>(_onPageChanged);
    on<CollectionChanged>(_onCollectionChanged);
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<ReportState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }

  void _onCollectionChanged(
    CollectionChanged event,
    Emitter<ReportState> emit,
  ) {
    emit(state.copyWith(collectionList: event.collectionList));
  }
}
