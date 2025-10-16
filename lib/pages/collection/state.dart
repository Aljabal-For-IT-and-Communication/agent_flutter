part of 'bloc.dart';

class CollectionState {
  const CollectionState({
    this.page = 0,
  });

  final int page;

  CollectionState copyWith({int? page}) {
    return CollectionState(page: page ?? this.page);
  }
}
