import 'package:app/common/values/colors.dart';
import 'package:app/pages/collection/view.dart';
import 'package:app/pages/home/view.dart';
import 'package:app/pages/pending_operations/view.dart';
import 'package:app/pages/report/view.dart';
import 'package:app/pages/sale_point/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPage();
}

class _ApplicationPage extends State<ApplicationPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
  }

  BottomNavigationBarItem tabBarItem(String label, String icon, int unread) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: <Widget>[
          SizedBox(
            width: 24.h,
            height: 24.h,
            child: Image.asset(
              icon,
              color: AppColors.primaryBackground,
            ),
          ),
          if (unread > 0)
            Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$unread',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      activeIcon: Stack(
        children: <Widget>[
          SizedBox(
            width: 24.h,
            height: 24.h,
            child: Image.asset(
              icon,
              color: AppColors.primaryFirstElement,
            ),
          ),
          if (unread > 0)
            Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$unread',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      label: label,
      backgroundColor: AppColors.primaryBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (value) {},
        children: const <Widget>[
          HomePage(),
          ReportPage(),
          CollectionPage(),
          PendingOperationsPage(),
          SalePointPage(),
        ],
      ),
      bottomNavigationBar: BlocBuilder<ApplicationBloc, ApplicationState>(
          builder: (context, state) {
        return Container(
          color: AppColors.primaryElement,
          child: SafeArea(
            top: false,
            child: BottomNavigationBar(
              elevation: 10,
              backgroundColor: Colors.transparent,
              items: [
                tabBarItem("home".tr(), "assets/icons/main.png", 0),
                tabBarItem("report".tr(), "assets/icons/doc1.png", 0),
                tabBarItem("collection".tr(), "assets/icons/wallets.png", 0),
                tabBarItem(
                    "Pending operations".tr(), "assets/icons/doc.png", 0),
                tabBarItem("sale points".tr(), "assets/icons/store.png", 0),
              ],
              currentIndex: state.page,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: (value) async {
                context.read<ApplicationBloc>().add(PageChanged(value));
                pageController.jumpToPage(value);
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: AppColors.primaryBackground,
              selectedItemColor: AppColors.primaryFirstElement,
            ),
          ),
        );
      }),
    );
  }
}
