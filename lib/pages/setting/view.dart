import 'package:app/common/entities/chat.dart';
import 'package:app/common/apis/chat.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/services/sql_db.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:app/common/widgets/toast.dart';
import 'package:app/global.dart';
import 'package:app/pages/setting/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        var language = Global.storageService.getLanguage();
        bool defaultLocale = language == 'ar' ? true : false;
        context.read<SettingBloc>().add(IsLanguageChanged(defaultLocale));
        context.read<SettingBloc>().add(
          IsOpenChanged(
            Global.storageService.getBool(STORAGE_NOTIFICATION_ENABLED_KEY),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                sliver: SliverToBoxAdapter(
                  child: BuildPublicAppBar(title: "Setting".tr()),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      BuildListItem(
                        title: "change password".tr(),
                        iconImage: "assets/icons/profile.png",
                        callFunc: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.ChangePassword);
                        },
                      ),
                      BuildListItem(
                        title: "Contact type".tr(),
                        iconImage: "assets/icons/wifi.png",
                        callFunc: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.ContactType);
                        },
                      ),
                      BuildNotification(),
                      BuildListItem(
                        title: "Privacy Policy".tr(),
                        iconImage: "assets/icons/lock.png",
                        iconColor: AppColors.primaryA,
                        callFunc: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.PrivacyPolicy);
                        },
                      ),
                      BuildListItem(
                        title: "Delete Account".tr(),
                        iconImage: "assets/icons/close.png",
                        callFunc: _confirmAccountDeletionRequest,
                      ),
                      BuildListItem(
                        title: "Contact us".tr(),
                        iconImage: "assets/icons/phone.png",
                        callFunc: () async {
                          // Navigator.of(context).pushNamed(AppRoutes.Contact);
                          ChatUserItem userItem = ChatUserItem();
                          userItem.token = SUPPORT_CHAT_TOKEN;
                          userItem.name = "support";
                          userItem.cid = 0;
                          userItem.avatar = "images/4.jpg";
                          userItem.msgNum = 0;
                          userItem.lastMsg = "no msg!";
                          userItem.lastTime = "";
                          SqlDbService sqlDbService = await SqlDbService()
                              .init();
                          // await sqlDbService.deleteAllChatUser();
                          var result = await sqlDbService.queryByTokenRow(
                            userItem.token,
                          );
                          if (result.isEmpty) {
                            await sqlDbService.insertChatUser(userItem);
                          }
                          await Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.Chat, arguments: userItem);
                        },
                      ),
                      BuildListItem(
                        title: "About the application".tr(),
                        iconImage: "assets/icons/question.png",
                        callFunc: () {
                          Navigator.of(context).pushNamed(AppRoutes.About);
                        },
                      ),
                      BuildLanguage(),
                      BuildListItem(
                        title: "Sign out".tr(),
                        iconImage: "assets/icons/close.png",
                        callFunc: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirm logout".tr()),
                                content: Text("Confirm logout.".tr()),
                                backgroundColor: AppColors.primaryBackground,
                                actions: [
                                  TextButton(
                                    child: Text("Cancel".tr()),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Confirm".tr()),
                                    onPressed: () {
                                      Global.storageService.remove(
                                        STORAGE_USER_PROFILE_KEY,
                                      );
                                      Global.storageService.remove(
                                        STORAGE_USER_TOKEN_KEY,
                                      );
                                      Navigator.of(
                                        context,
                                      ).pushNamedAndRemoveUntil(
                                        AppRoutes.Sign_in,
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmAccountDeletionRequest() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Delete Account".tr()),
          content: Text("Delete account request explanation".tr()),
          backgroundColor: AppColors.primaryBackground,
          actions: [
            TextButton(
              child: Text("Cancel".tr()),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text("Send request".tr()),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await _sendAccountDeletionRequest();
    }
  }

  Future<void> _sendAccountDeletionRequest() async {
    try {
      final user = Global.storageService.getUserProfile();
      final entity = ChatRequestEntity()
        ..toToken = SUPPORT_CHAT_TOKEN
        ..toCid = 0
        ..content =
            "Account deletion request for agent ID ${user.id ?? '-'}, phone ${user.phone ?? '-'}, name ${user.firstName ?? ''} ${user.lastName ?? ''}. Please delete the account and associated personal data that is not legally required to be retained.";
      final response = await ChatAPI.sendMessage(params: entity);
      if (response.code == 0) {
        toastInfo(msg: "Account deletion request sent".tr());
      } else {
        toastInfo(msg: response.msg ?? "Error".tr());
      }
    } catch (_) {
      toastInfo(msg: "Error".tr());
    }
  }
}
