part of 'bloc.dart';

abstract class CollectionEvent {
  const CollectionEvent();
}


class PageChanged extends CollectionEvent {
  const PageChanged(this.page);

  final int page;
}