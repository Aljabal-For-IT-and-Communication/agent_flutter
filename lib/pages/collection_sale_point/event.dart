part of 'bloc.dart';

abstract class CollectionSalePointEvent {
  const CollectionSalePointEvent();
}


class AgentCollectRecordListChanged extends CollectionSalePointEvent {
  const AgentCollectRecordListChanged(this.agentCollectRecordList);

  final List<AgentCollectRecordData> agentCollectRecordList;
}

class PageChanged extends CollectionSalePointEvent {
  const PageChanged(this.page);

  final int page;
}

class IsMoreChanged extends CollectionSalePointEvent {
  const IsMoreChanged(this.isMore);

  final bool isMore;
}

class AmountChanged extends CollectionSalePointEvent {
  const AmountChanged(this.amount);
  final String amount;
}

class StartDateChanged extends CollectionSalePointEvent {
  const StartDateChanged(this.startDate);
  final String startDate;
}

class EndDateChanged extends CollectionSalePointEvent {
  const EndDateChanged(this.endDate);
  final String endDate;
}