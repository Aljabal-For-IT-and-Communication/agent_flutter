part of 'bloc.dart';

class TransformationState {
  const TransformationState({
    this.page = 0,
  });

  final int page;

  TransformationState copyWith({int? page}) {
    return TransformationState(page: page ?? this.page);
  }
}
