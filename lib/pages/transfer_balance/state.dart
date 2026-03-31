part of 'bloc.dart';

class TransferBalanceState {
  const TransferBalanceState({
    this.userProfile,
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.agentItem,
    this.salePointItem,
    this.phone = "",
    this.Amount = "",
    this.type = "recharge",
    this.agent = "Agent",
    this.page = 0,
    this.rechargeTypes = const <RechargeTypeData>[],
    this.rechargeTypeId,
    this.validationFilePath,
    this.validationFileName,
    this.formVersion = 0,
    this.isLocked = false,
  });
  final UserItem? userProfile;
  final bool isLocked;
  final String phone;
  final String Amount;
  final String type;
  final String agent;
  final int page;
  final List<SalePointData> salePointList;
  final List<AgentData> agentList;
  final AgentData? agentItem;
  final SalePointData? salePointItem;
  final List<RechargeTypeData> rechargeTypes;
  final int? rechargeTypeId;
  final String? validationFilePath;
  final String? validationFileName;
  final int formVersion;

  TransferBalanceState copyWith({
    List<SalePointData>? salePointList,
    List<AgentData>? agentList,
    AgentData? agentItem,
    SalePointData? salePointItem,
    String? phone,
    String? Amount,
    String? type,
    String? agent,
    int? page,
    UserItem? userProfile,
    List<RechargeTypeData>? rechargeTypes,
    int? rechargeTypeId,
    String? validationFilePath,
    String? validationFileName,
    bool clearValidationFile = false,
    int? formVersion,
    bool? isLocked,
  }) {
    return TransferBalanceState(
      salePointList: salePointList ?? this.salePointList,
      agentList: agentList ?? this.agentList,
      phone: phone ?? this.phone,
      Amount: Amount ?? this.Amount,
      type: type ?? this.type,
      agent: agent ?? this.agent,
      agentItem: agentItem ?? this.agentItem,
      salePointItem: salePointItem ?? this.salePointItem,
      page: page ?? this.page,
      userProfile: userProfile ?? this.userProfile,
      rechargeTypes: rechargeTypes ?? this.rechargeTypes,
      rechargeTypeId: rechargeTypeId ?? this.rechargeTypeId,
      validationFilePath: clearValidationFile
          ? null
          : (validationFilePath ?? this.validationFilePath),
      validationFileName: clearValidationFile
          ? null
          : (validationFileName ?? this.validationFileName),
      formVersion: formVersion ?? this.formVersion,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
