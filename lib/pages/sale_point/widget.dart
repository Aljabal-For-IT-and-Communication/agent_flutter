import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/common/values/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'logic.dart';

Widget outlinedText(
  String text, {
  required Color fillColor,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.bold,
  Color strokeColor = Colors.black,
  double strokeWidth = 0.3,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Stack(
    children: [
      Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = strokeColor,
        ),
      ),
      Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          color: fillColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    ],
  );
}

class BuildAppBar extends StatelessWidget {
  BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 375.w,
      padding:
          EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w, bottom: 30.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/icons/headbg3.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Container(
            width: 343.w,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 260.w,
                  child: Text(
                    "Points of sale".tr(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class BuildListItem extends StatefulWidget {
  final SalePointData item;
  const BuildListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<BuildListItem> createState() => _BuildListItemState();
}

class _BuildListItemState extends State<BuildListItem> {
  late final TextEditingController _firstName;
  late final TextEditingController _middleName;
  late final TextEditingController _lastName;
  late final TextEditingController _businessName;
  late final TextEditingController _machineNumber;

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController(text: widget.item.firstName ?? '');
    _middleName = TextEditingController(text: widget.item.middleName ?? '');
    _lastName = TextEditingController(text: widget.item.lastName ?? '');
    _businessName = TextEditingController(text: widget.item.businessName ?? '');
    _machineNumber =
        TextEditingController(text: widget.item.machineNumber ?? '');
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _businessName.dispose();
    _machineNumber.dispose();
    super.dispose();
  }

  void _resetControllersToItem() {
    _firstName.text = widget.item.firstName ?? '';
    _middleName.text = widget.item.middleName ?? '';
    _lastName.text = widget.item.lastName ?? '';
    _businessName.text = widget.item.businessName ?? '';
    _machineNumber.text = widget.item.machineNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final balance = double.tryParse(item.balance ?? "0") ?? 0;
    final int currentId = item.id ?? -1;
    final int? editingId =
        context.select((SalePointBloc b) => b.state.editingSalePointId);
    final bool isEditing = editingId == currentId && currentId != -1;

    Widget _buildReadonly() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(8.w),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
            ),
            child: Image.asset('assets/icons/store.png'),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 270.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: outlinedText(
                          "${item.businessName}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.w),
                        child: outlinedText(
                          "${item.firstName}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: AppColors.primarySecondaryElementText,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.w),
                        child: outlinedText(
                          "${item.phone}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: AppColors.primarySecondaryElementText,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      if ((item.lastLogin ?? '').isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 5.w),
                          child: outlinedText(
                            "${'Last activity'.tr()}: ${timeFormated(item.lastLogin)}",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fillColor: AppColors.primarySecondaryElementText,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp,
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.only(top: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            outlinedText(
                              "${"Balance".tr()} : ${item.indebtedness ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: balance <= 300
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Indebtedness".tr()} : ${item.balance ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: balance >= 1000
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    ChatUserItem userItem = ChatUserItem();
                    userItem.token = item.token;
                    userItem.name = item.firstName;
                    userItem.cid = item.cid ?? 0;
                    userItem.avatar = item.avatar;
                    userItem.msgNum = 0;
                    userItem.lastMsg = 'no msg!';
                    userItem.lastTime = '';
                    Logic(context: context).goChat(userItem);
                  },
                  child: Container(
                    width: 60.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryElement,
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                    ),
                    alignment: Alignment.center,
                    child: outlinedText(
                      'chat'.tr(),
                      fillColor: AppColors.primaryBackground,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    InputDecoration _inputDec(String label) => InputDecoration(
          isDense: true,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.w)),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        );

    Widget _buildEditor() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(8.w),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
            ),
            child: Image.asset('assets/icons/store.png'),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _businessName,
                  decoration: _inputDec('Business Name'.tr()),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstName,
                        decoration: _inputDec('First Name'.tr()),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: _middleName,
                        decoration: _inputDec('Middle Name'.tr()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _lastName,
                        decoration: _inputDec('Last Name'.tr()),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: _machineNumber,
                        decoration: _inputDec('Machine Number'.tr()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Container(
        padding:
            EdgeInsets.only(top: 12.h, bottom: 12.h, left: 10.w, right: 10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primaryFourElementText,
          border:
              Border.all(color: AppColors.primaryThreeElementText, width: 1.h),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: activate/deactivate, edit/cancel and optional Save on the left
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryElement,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                    ),
                    onPressed: () {
                      Logic(context: context).toggleSalePointStatus(item);
                    },
                    child: Text(
                      (item.status != 1 ? 'Activate' : 'Deactivate').tr(),
                      style: TextStyle(
                        color: AppColors.primaryBackground,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                InkWell(
                  onTap: () {
                    if (currentId == -1) return;
                    if (isEditing) {
                      _resetControllersToItem();
                      context
                          .read<SalePointBloc>()
                          .add(const SetEditingSalePoint(null));
                    } else {
                      _resetControllersToItem();
                      context
                          .read<SalePointBloc>()
                          .add(SetEditingSalePoint(currentId));
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isEditing
                          ? AppColors.primaryRed
                          : AppColors.primaryElement,
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isEditing ? Icons.close : Icons.edit,
                          size: 14.sp,
                          color: AppColors.primaryBackground,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          isEditing ? 'Cancel'.tr() : 'Edit'.tr(),
                          style: TextStyle(
                            color: AppColors.primaryBackground,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isEditing) ...[
                  SizedBox(width: 8.w),
                  SizedBox(
                    height: 32.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryElement,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                      ),
                      onPressed: () {
                        Logic(context: context).saveSalePointEdits(
                          item,
                          firstName: _firstName.text,
                          middleName: _middleName.text,
                          lastName: _lastName.text,
                          businessName: _businessName.text,
                          machineNumber: _machineNumber.text,
                        );
                      },
                      child: Text(
                        'Save'.tr(),
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 10.h),
            isEditing ? _buildEditor() : _buildReadonly(),
          ],
        ),
      ),
    );
  }
}

class BuildAgentListItem extends StatelessWidget {
  final AgentData item;
  const BuildAgentListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var balance = double.parse(item.indebtedness ?? "0");
    var realDebt = double.parse(item.realDebt ?? "0");
    var pendingRevenue = double.parse(item.pendingRevenue ?? "0");
    var agentDebt = double.parse(item.agentDebt ?? "0");
    var salePointsDebt = double.parse(item.salePointsDebt ?? "0");

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:
            EdgeInsets.only(top: 12.h, bottom: 12.h, left: 10.w, right: 10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primaryFourElementText,
          border:
              Border.all(color: AppColors.primaryThreeElementText, width: 1.h),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(8.w),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
              ),
              child: Image.asset('assets/icons/store.png'),
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 270.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 180.w,
                        margin: EdgeInsets.only(top: 5.w),
                        child: outlinedText(
                          "${item.firstName} ${item.middleName} ${item.lastName}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: AppColors.primaryText,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Container(
                        width: 180.w,
                        margin: EdgeInsets.only(top: 5.w),
                        child: outlinedText(
                          "${item.phone}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fillColor: AppColors.primaryText,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            outlinedText(
                              "${"Balance".tr()} : ${item.indebtedness ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: balance <= 300
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Agents Debt".tr()} : ${item.subAgentsDebt ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: agentDebt < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Sale Points Debt".tr()} : ${item.salePointsDebt ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: salePointsDebt < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Pending Revenue".tr()} : ${item.pendingRevenue ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: pendingRevenue < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Indebtedness".tr()} : ${item.realDebt ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: realDebt < 0
                                  ? AppColors.primaryRed
                                  : AppColors.primarySuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 10.h),
                            outlinedText(
                              "${"Ceiling".tr()} : ${item.balance ?? 0} LYD",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fillColor: AppColors.primaryElement,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      ChatUserItem userItem = ChatUserItem();
                      userItem.token = item.token;
                      userItem.name = item.firstName;
                      userItem.cid = item.cid ?? 0;
                      userItem.avatar = item.avatar;
                      userItem.msgNum = 0;
                      userItem.lastMsg = "no msg!";
                      userItem.lastTime = "";
                      Logic(context: context).goChat(userItem);
                    },
                    child: Container(
                      width: 60.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      ),
                      alignment: Alignment.center,
                      child: outlinedText(
                        "chat".tr(),
                        fillColor: AppColors.primaryBackground,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
