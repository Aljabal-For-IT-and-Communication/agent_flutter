part of 'bloc.dart';

abstract class TransformationEvent {
  const TransformationEvent();
}

class PageChanged extends TransformationEvent {
  const PageChanged(this.page);

  final int page;
}
