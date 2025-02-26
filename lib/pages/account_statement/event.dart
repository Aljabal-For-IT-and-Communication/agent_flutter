part of 'bloc.dart';

abstract class AccountStatementEvent {
  const AccountStatementEvent();
}

class AccountStatementChanged extends AccountStatementEvent {
  const AccountStatementChanged(this.accountStatement);

  final AccountStatementData accountStatement;
}

class PageChanged extends AccountStatementEvent {
  const PageChanged(this.page);

  final int page;
}

class StartDateChanged extends AccountStatementEvent {
  const StartDateChanged(this.startDate);
  final String startDate;
}

class EndDateChanged extends AccountStatementEvent {
  const EndDateChanged(this.endDate);
  final String endDate;
}