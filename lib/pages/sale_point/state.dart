part of 'bloc.dart';

class SalePointState {
  const SalePointState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.page = 0,
  });


  final int page;
  final List<AgentData> agentList;
  final List<SalePointData> salePointList;

  SalePointState copyWith({
    List<SalePointData>? salePointList,
    List<AgentData>? agentList,
    int? page
  }) {
    return SalePointState(
      agentList: agentList ?? this.agentList,
      salePointList: salePointList ?? this.salePointList,
      page:page??this.page
    );
  }
}
