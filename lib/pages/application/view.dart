import 'package:app/common/services/socketchannel.dart';
import 'package:app/common/values/colors.dart';
import 'package:app/pages/chat_user/view.dart';
import 'package:app/pages/collection/view.dart';
import 'package:app/pages/home/view.dart';
import 'package:app/pages/report/view.dart';
import 'package:app/pages/sale_point/view.dart';
import 'package:app/pages/transformation/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/services/sql_db.dart';
import '../../global.dart';
import 'bloc.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPage();
}

class _ApplicationPage extends State<ApplicationPage> {
  int _unreadMessages = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async{
      if (mounted) {
       await SocketDbService().init();
      }
      SqlDbService sqlDbService = await SqlDbService().init();
      var unreadMsg = await sqlDbService.getUnreadMsgNum();
      print(unreadMsg);
      setState(() {
        _unreadMessages = unreadMsg;
      });
    });
    Global.eventBus.on<WebSocketEvent>().listen((event) async{
      SqlDbService sqlDbService = await SqlDbService().init();
      var unreadMsg = await sqlDbService.getUnreadMsgNum();
      print(unreadMsg);
      setState(() {
        _unreadMessages = unreadMsg;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

 final PageController pageController = new PageController(initialPage: 0);

  BottomNavigationBarItem tabBarItem(String label, String icon,int unread) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: <Widget>[
          Container(
              width: 24.h,
              height: 24.h,
              child: Image.asset(
                icon,
                color: AppColors.primaryBackground,
              )),
          if (unread > 0)
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$unread',
                  style: TextStyle(
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
          Container(
              width: 24.h,
              height: 24.h,
              child: Image.asset(
                icon,
                color: AppColors.primaryFirstElement,
              )),
          if (unread > 0)
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$unread',
                  style: TextStyle(
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
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(),
            ReportPage(),
            CollectionPage(),
            ChatUserPage(),
            SalePointPage(),
          ],
          controller: pageController,
          onPageChanged: (value) {},
        ),
        bottomNavigationBar:
        BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (context, state) {
              return Container(
                width: 375.w,
                height: 70.h,
                color: AppColors.primaryElement,
                child: BottomNavigationBar(
                  elevation: 10,
                  backgroundColor: AppColors.primaryElement,
                  items: [
                    tabBarItem("home".tr(),"assets/icons/main.png",0),
                    tabBarItem("report".tr(),"assets/icons/doc1.png",0),
                    tabBarItem("collection".tr(),"assets/icons/wallets.png",0),
                    tabBarItem("message".tr(),"assets/icons/message.png",_unreadMessages),
                    tabBarItem("sale points".tr(),"assets/icons/store.png",0),
                  ],
                  currentIndex: state.page,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) async{
                    context.read<ApplicationBloc>().add(PageChanged(value));
                    pageController.jumpToPage(value);
                    SqlDbService sqlDbService = await SqlDbService().init();
                    var unreadMsg = await sqlDbService.getUnreadMsgNum();
                    setState(() {
                      _unreadMessages = unreadMsg;
                    });
                  },
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  unselectedItemColor: AppColors.primaryBackground,
                  selectedItemColor: AppColors.primaryFirstElement,
                ),
              );
            }));
  }

}

