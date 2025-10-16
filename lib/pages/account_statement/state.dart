part of 'bloc.dart';

class AccountStatementState {
  const AccountStatementState({
    this.accountStatement,
    this.startDate = "",
    this.endDate = "",
    this.page = 0,
  });

  final String? startDate;
  final String? endDate;
  final int page;
  final AccountStatementData? accountStatement;

  AccountStatementState copyWith(
      {AccountStatementData? accountStatement,
      String? startDate,
      String? endDate,
      int? page}) {
    return AccountStatementState(
        accountStatement: accountStatement ?? this.accountStatement,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        page: page ?? this.page);
  }
}
