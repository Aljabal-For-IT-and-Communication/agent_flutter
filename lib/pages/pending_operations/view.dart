import 'package:app/common/apis/apis.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/logger.dart';
import 'package:app/common/values/colors.dart';
import 'package:app/common/widgets/app.dart';
import 'package:app/pages/home/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingOperationsPage extends StatefulWidget {
  const PendingOperationsPage({super.key});

  @override
  State<PendingOperationsPage> createState() => _PendingOperationsPageState();
}

class _PendingOperationsPageState extends State<PendingOperationsPage> {
  late Future<List<PendingTransactionData>> _pendingOperations;

  @override
  void initState() {
    super.initState();
    _pendingOperations = _loadPendingOperations();
  }

  Future<List<PendingTransactionData>> _loadPendingOperations() async {
    try {
      final result = await HomeAPI.pendingTransactionsList();
      if (result.code == 0) {
        return result.data ?? [];
      }
      Logger.write("pendingTransactionsList failed: ${result.msg}");
    } catch (e) {
      Logger.write("$e");
    }
    return [];
  }

  Future<void> _refresh() async {
    final future = _loadPendingOperations();
    setState(() {
      _pendingOperations = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: FutureBuilder<List<PendingTransactionData>>(
        future: _pendingOperations,
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];
          return RefreshIndicator(
            onRefresh: _refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: BuildPublicAppBar(
                    title: "Pending operations".tr(),
                    showBack: false,
                  ),
                ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryElement,
                      ),
                    ),
                  )
                else if (items.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "No pending operations".tr(),
                        style: TextStyle(
                          color: AppColors.primarySecondaryElementText,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 16.w,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return BuildPendingTransactionListItem(
                            item: items[index],
                          );
                        },
                        childCount: items.length,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
