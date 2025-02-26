part of 'bloc.dart';

abstract class CollectionWhatEvent {
  const CollectionWhatEvent();
}


class AgentCollectRecordListChanged extends CollectionWhatEvent {
  const AgentCollectRecordListChanged(this.agentCollectRecordList);

  final List<AgentCollectRecordData> agentCollectRecordList;
}

class PageChanged extends CollectionWhatEvent {
  const PageChanged(this.page);

  final int page;
}

class IsMoreChanged extends CollectionWhatEvent {
  const IsMoreChanged(this.isMore);

  final bool isMore;
}

class AmountChanged extends CollectionWhatEvent {
  const AmountChanged(this.amount);
  final String amount;
}

class StartDateChanged extends CollectionWhatEvent {
  const StartDateChanged(this.startDate);
  final String startDate;
}

class EndDateChanged extends CollectionWhatEvent {
  const EndDateChanged(this.endDate);
  final String endDate;
}