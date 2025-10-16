part of 'bloc.dart';

abstract class CreditEvent {
  const CreditEvent();
}

class UserProfileChanged extends CreditEvent {
  const UserProfileChanged(this.userProfile);

  final UserItem userProfile;
}

class PageChanged extends CreditEvent {
  const PageChanged(this.page);

  final int page;
}

class AmountChanged extends CreditEvent {
  const AmountChanged(this.Amount);

  final String Amount;
}
