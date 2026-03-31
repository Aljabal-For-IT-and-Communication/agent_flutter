part of 'bloc.dart';

class CollectionItemState {
  const CollectionItemState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.agentItem,
    this.salePointItem,
    this.phone = "",
    this.Amount = "",
    this.type = "recharge",
    this.agent = "Agent",
    this.isShow = false,
    this.collectTypes = const <CollectTypeData>[],
    this.collectTypeId,
    this.validationFilePath,
    this.validationFileName,
    this.formVersion = 0,
    this.isLocked = false,
  });

  final String phone;
  final String Amount;
  final String type;
  final String agent;
  final bool isShow;
  final List<SalePointData> salePointList;
  final List<AgentData> agentList;
  final AgentData? agentItem;
  final SalePointData? salePointItem;
  final List<CollectTypeData> collectTypes;
  final int? collectTypeId;
  final String? validationFilePath;
  final String? validationFileName;
  final int formVersion;
  final bool isLocked;

  CollectionItemState copyWith({
    List<SalePointData>? salePointList,
    List<AgentData>? agentList,
    AgentData? agentItem,
    SalePointData? salePointItem,
    String? phone,
    String? Amount,
    String? type,
    String? agent,
    bool? isShow,
    List<CollectTypeData>? collectTypes,
    int? collectTypeId,
    String? validationFilePath,
    String? validationFileName,
    bool clearValidationFile = false,
    int? formVersion,
    bool? isLocked,
  }) {
    return CollectionItemState(
        salePointList: salePointList ?? this.salePointList,
        agentList: agentList ?? this.agentList,
        phone: phone ?? this.phone,
        Amount: Amount ?? this.Amount,
        type: type ?? this.type,
        agent: agent ?? this.agent,
        agentItem: agentItem ?? this.agentItem,
        salePointItem: salePointItem ?? this.salePointItem,
        isShow: isShow ?? this.isShow,
        collectTypes: collectTypes ?? this.collectTypes,
        collectTypeId: collectTypeId ?? this.collectTypeId,
        validationFilePath: clearValidationFile
            ? null
            : (validationFilePath ?? this.validationFilePath),
        validationFileName: clearValidationFile
            ? null
            : (validationFileName ?? this.validationFileName),
        formVersion: formVersion ?? this.formVersion,
        isLocked: isLocked ?? this.isLocked);
  }
}
