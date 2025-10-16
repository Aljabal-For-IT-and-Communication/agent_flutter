import 'package:app/pages/about/about.dart';
import 'package:app/pages/account/bloc.dart';
import 'package:app/pages/account/view.dart';
import 'package:app/pages/account_statement/bloc.dart';
import 'package:app/pages/account_statement/view.dart';
import 'package:app/pages/application/bloc.dart';
import 'package:app/pages/application/view.dart';
import 'package:app/pages/chat/bloc.dart';
import 'package:app/pages/chat/view.dart';
import 'package:app/pages/chat_user/bloc.dart';
import 'package:app/pages/chat_user/view.dart';
import 'package:app/pages/collection/bloc.dart';
import 'package:app/pages/collection/view.dart';
import 'package:app/pages/collection_item/bloc.dart';
import 'package:app/pages/collection_item/view.dart';
import 'package:app/pages/collection_sale_point/bloc.dart';
import 'package:app/pages/collection_sale_point/view.dart';
import 'package:app/pages/collection_what/bloc.dart';
import 'package:app/pages/collection_what/view.dart';
import 'package:app/pages/contact/contact.dart';
import 'package:app/pages/contact_type/contact_type.dart';
import 'package:app/pages/credit/bloc.dart';
import 'package:app/pages/credit/view.dart';
import 'package:app/pages/debit/bloc.dart';
import 'package:app/pages/debit/view.dart';
import 'package:app/pages/frame/change_password/bloc.dart';
import 'package:app/pages/frame/change_password/view.dart';
import 'package:app/pages/frame/forget/bloc.dart';
import 'package:app/pages/frame/forget/view.dart';
import 'package:app/pages/frame/register/bloc.dart';
import 'package:app/pages/frame/register/view.dart';
import 'package:app/pages/frame/sign_in/bloc.dart';
import 'package:app/pages/frame/sign_in/view.dart';
import 'package:app/pages/frame/splash/splash.dart';
import 'package:app/pages/home/bloc.dart';
import 'package:app/pages/home/view.dart';
import 'package:app/pages/message/bloc.dart';
import 'package:app/pages/message/view.dart';
import 'package:app/pages/message_detail/bloc.dart';
import 'package:app/pages/message_detail/view.dart';
import 'package:app/pages/my_report/bloc.dart';
import 'package:app/pages/my_report/view.dart';
import 'package:app/pages/photoview/photoview.dart';
import 'package:app/pages/profile/bloc.dart';
import 'package:app/pages/profile/view.dart';
import 'package:app/pages/report/bloc.dart';
import 'package:app/pages/report/view.dart';
import 'package:app/pages/revenue/bloc.dart';
import 'package:app/pages/revenue/view.dart';
import 'package:app/pages/sale_point/bloc.dart';
import 'package:app/pages/sale_point/view.dart';
import 'package:app/pages/setting/bloc.dart';
import 'package:app/pages/setting/view.dart';
import 'package:app/pages/shipment/bloc.dart';
import 'package:app/pages/shipment/view.dart';
import 'package:app/pages/shipping_operation/bloc.dart';
import 'package:app/pages/shipping_operation/view.dart';
import 'package:app/pages/transfer_balance/bloc.dart';
import 'package:app/pages/transfer_balance/view.dart';
import 'package:app/pages/transformation/bloc.dart';
import 'package:app/pages/transformation/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/common/routes/observers.dart';
import 'package:app/global.dart';

import 'routes.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static List<PageEntity> Routes() {
    return [
      PageEntity(path: AppRoutes.Splash, page: Splash(), bloc: null),
      PageEntity(
          path: AppRoutes.Sign_in,
          page: SignInPage(),
          bloc: BlocProvider(create: (_) => SignInBloc())),
      PageEntity(
          path: AppRoutes.Register,
          page: RegisterPage(),
          bloc: BlocProvider(create: (_) => RegisterBloc())),
      PageEntity(
          path: AppRoutes.Forget,
          page: ForgetPage(),
          bloc: BlocProvider(create: (_) => ForgetBloc())),
      PageEntity(
          path: AppRoutes.Application,
          page: ApplicationPage(),
          bloc: BlocProvider(create: (_) => ApplicationBloc())),
      PageEntity(
          path: AppRoutes.Home,
          page: HomePage(),
          bloc: BlocProvider(create: (_) => HomeBloc())),
      PageEntity(
          path: AppRoutes.Message,
          page: MessagePage(),
          bloc: BlocProvider(create: (_) => MessageBloc())),
      PageEntity(
          path: AppRoutes.Profile,
          page: ProfilePage(),
          bloc: BlocProvider(create: (_) => ProfileBloc())),
      PageEntity(
          path: AppRoutes.Setting,
          page: SettingPage(),
          bloc: BlocProvider(create: (_) => SettingBloc())),
      PageEntity(
          path: AppRoutes.Account,
          page: AccountPage(),
          bloc: BlocProvider(create: (_) => AccountBloc())),
      PageEntity(
          path: AppRoutes.MessageDetail,
          page: MessageDetailPage(),
          bloc: BlocProvider(create: (_) => MessageDetailBloc())),
      PageEntity(
          path: AppRoutes.ChangePassword,
          page: ChangePasswordPage(),
          bloc: BlocProvider(create: (_) => ChangePasswordBloc())),
      PageEntity(
          path: AppRoutes.Report,
          page: ReportPage(),
          bloc: BlocProvider(create: (_) => ReportBloc())),
      PageEntity(
          path: AppRoutes.Transformation,
          page: TransformationPage(),
          bloc: BlocProvider(create: (_) => TransformationBloc())),
      PageEntity(
          path: AppRoutes.AccountStatement,
          page: AccountStatementPage(),
          bloc: BlocProvider(create: (_) => AccountStatementBloc())),
      PageEntity(
          path: AppRoutes.TransferBalance,
          page: TransferBalancePage(),
          bloc: BlocProvider(create: (_) => TransferBalanceBloc())),
      PageEntity(
          path: AppRoutes.SalePoint,
          page: SalePointPage(),
          bloc: BlocProvider(create: (_) => SalePointBloc())),
      PageEntity(
          path: AppRoutes.Collection,
          page: CollectionPage(),
          bloc: BlocProvider(create: (_) => CollectionBloc())),
      PageEntity(
          path: AppRoutes.Credit,
          page: CreditPage(),
          bloc: BlocProvider(create: (_) => CreditBloc())),
      PageEntity(
          path: AppRoutes.CollectionItem,
          page: CollectionItemPage(),
          bloc: BlocProvider(create: (_) => CollectionItemBloc())),
      PageEntity(
          path: AppRoutes.CollectionSalePoint,
          page: CollectionSalePointPage(),
          bloc: BlocProvider(create: (_) => CollectionSalePointBloc())),
      PageEntity(
          path: AppRoutes.CollectionWhat,
          page: CollectionWhatPage(),
          bloc: BlocProvider(create: (_) => CollectionWhatBloc())),
      PageEntity(
          path: AppRoutes.ShippingOperation,
          page: ShippingOperationPage(),
          bloc: BlocProvider(create: (_) => ShippingOperationBloc())),
      PageEntity(
          path: AppRoutes.Revenue,
          page: RevenuePage(),
          bloc: BlocProvider(create: (_) => RevenueBloc())),
      PageEntity(
          path: AppRoutes.Shipment,
          page: ShipmentPage(),
          bloc: BlocProvider(create: (_) => ShipmentBloc())),
      PageEntity(
          path: AppRoutes.Debit,
          page: DebitPage(),
          bloc: BlocProvider(create: (_) => DebitBloc())),
      PageEntity(
          path: AppRoutes.MyReport,
          page: MyReportPage(),
          bloc: BlocProvider(create: (_) => MyReportBloc())),
      PageEntity(
          path: AppRoutes.Chat,
          page: ChatPage(),
          bloc: BlocProvider(create: (_) => ChatBloc())),
      PageEntity(
          path: AppRoutes.ChatUser,
          page: ChatUserPage(),
          bloc: BlocProvider(create: (_) => ChatUserBloc())),
      PageEntity(
          path: AppRoutes.Photoimgview, page: PhotoViewPage(), bloc: null),
      PageEntity(
          path: AppRoutes.ContactType, page: ContactTypePage(), bloc: null),
      PageEntity(path: AppRoutes.About, page: AboutPage(), bloc: null),
      PageEntity(path: AppRoutes.Contact, page: ContactPage(), bloc: null),
    ];
  }

  static List<dynamic> Blocer(BuildContext context) {
    List<dynamic> blocerList = <dynamic>[];
    for (var blocer in Routes()) {
      if (blocer.bloc != null) {
        blocerList.add(blocer.bloc);
      }
    }
    return blocerList;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = Routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        if (result.first.path == AppRoutes.Splash) {
          bool isLogin = Global.storageService.getIsLogin();
          if (isLogin) {
            return MaterialPageRoute<void>(
                builder: (_) => ApplicationPage(), settings: settings);
          }
          return MaterialPageRoute<void>(
              builder: (_) => SignInPage(), settings: settings);
        }
        return MaterialPageRoute<void>(
            builder: (_) => result.first.page, settings: settings);
      }
    }

    return MaterialPageRoute<void>(
        builder: (_) => SignInPage(), settings: settings);
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.path,
    required this.page,
    this.bloc,
  });
}
