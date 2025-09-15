part of 'bloc.dart';

class SalePointState {
  const SalePointState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.page = 0,
    this.editingSalePointId,
  });

  final int page;
  final List<AgentData> agentList;
  final List<SalePointData> salePointList;
  final int? editingSalePointId;

  SalePointState copyWith({
    List<SalePointData>? salePointList,
    List<AgentData>? agentList,
    int? page,
    int? editingSalePointId,
  }) {
    return SalePointState(
      agentList: agentList ?? this.agentList,
      salePointList: salePointList ?? this.salePointList,
      page: page ?? this.page,
      editingSalePointId: editingSalePointId ?? this.editingSalePointId,
    );
  }
}
