part of 'bloc.dart';

abstract class ReportEvent {
  const ReportEvent();
}


class PageChanged extends ReportEvent {
  const PageChanged(this.page);

  final int page;
}

class CollectionChanged extends ReportEvent {
  const CollectionChanged(this.collectionList);

  final List<BaseData> collectionList;
}