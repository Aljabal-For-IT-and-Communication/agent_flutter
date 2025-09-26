part of 'bloc.dart';

class SalePointState {
  const SalePointState({
    this.salePointList = const <SalePointData>[],
    this.agentList = const <AgentData>[],
    this.page = 0,
    this.editingSalePointId,
    this.salePointSearch = '',
    this.agentSearch = '',
    this.salePointSortField = SortField.none,
    this.salePointSortAsc = false,
    this.agentSortField = SortField.none,
    this.agentSortAsc = false,
  });

  final int page;
  final List<AgentData> agentList;
  final List<SalePointData> salePointList;
  final int? editingSalePointId;
  final String salePointSearch;
  final String agentSearch;
  final SortField salePointSortField;
  final bool salePointSortAsc;
  final SortField agentSortField;
  final bool agentSortAsc;

  SalePointState copyWith({
    List<SalePointData>? salePointList,
    List<AgentData>? agentList,
    int? page,
    int? editingSalePointId,
    String? salePointSearch,
    String? agentSearch,
    SortField? salePointSortField,
    bool? salePointSortAsc,
    SortField? agentSortField,
    bool? agentSortAsc,
  }) {
    return SalePointState(
      agentList: agentList ?? this.agentList,
      salePointList: salePointList ?? this.salePointList,
      page: page ?? this.page,
      editingSalePointId: editingSalePointId ?? this.editingSalePointId,
      salePointSearch: salePointSearch ?? this.salePointSearch,
      agentSearch: agentSearch ?? this.agentSearch,
      salePointSortField: salePointSortField ?? this.salePointSortField,
      salePointSortAsc: salePointSortAsc ?? this.salePointSortAsc,
      agentSortField: agentSortField ?? this.agentSortField,
      agentSortAsc: agentSortAsc ?? this.agentSortAsc,
    );
  }
}

enum SortField { none, balance, indebtedness }
