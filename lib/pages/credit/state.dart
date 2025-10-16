part of 'bloc.dart';

class CreditState {
  const CreditState({
    this.page = 0,
    this.Amount = "",
    this.userProfile,
  });

  final int page;
  final String Amount;
  final UserItem? userProfile;

  CreditState copyWith({int? page, String? Amount, UserItem? userProfile}) {
    return CreditState(
        page: page ?? this.page,
        Amount: Amount ?? this.Amount,
        userProfile: userProfile ?? this.userProfile);
  }
}
