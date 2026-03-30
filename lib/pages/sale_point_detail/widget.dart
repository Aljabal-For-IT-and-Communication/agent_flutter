import 'package:app/common/apis/sale_point.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/routes/names.dart';
import 'package:app/common/services/sql_db.dart';
import 'package:app/common/utils/date.dart';
import 'package:app/common/utils/loading.dart';

import 'package:app/common/values/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ─── App bar ───────────────────────────────────────────────
class DetailAppBar extends StatelessWidget {
  final SalePointData item;
  const DetailAppBar({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      padding:
          EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        image: const DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/icons/headbg3.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.arrow_back_ios,
                    color: AppColors.primaryBackground, size: 20.sp),
              ),
              Expanded(
                child: Text(
                  item.businessName ?? 'Sale Point'.tr(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 20.sp), // balance for back icon
            ],
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}

// ─── Info card ─────────────────────────────────────────────
class SalePointInfoCard extends StatelessWidget {
  final SalePointData item;
  final double balance;
  const SalePointInfoCard({Key? key, required this.item, required this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryFourElementText,
        border:
            Border.all(color: AppColors.primaryThreeElementText, width: 1.h),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Business name row
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(22.w),
                ),
                child: Image.asset('assets/icons/store.png'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  item.businessName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 24.h),
          _row('Name'.tr(),
              '${item.firstName ?? ''} ${item.middleName ?? ''} ${item.lastName ?? ''}'),
          _row('Phone'.tr(), item.phone ?? ''),
          _row('Machine Number'.tr(), item.machineNumber ?? ''),
          if ((item.lastLogin ?? '').isNotEmpty)
            _row('Last activity'.tr(), timeFormated(item.lastLogin)),
          _row(
              'Status'.tr(), item.status == 1 ? 'Active'.tr() : 'Inactive'.tr(),
              valueColor: item.status == 1
                  ? AppColors.primarySuccess
                  : AppColors.primaryRed),
          SizedBox(height: 8.h),
          // Balance / Indebtedness
          Row(
            children: [
              Expanded(
                child: _balanceChip(
                  'Balance'.tr(),
                  '${item.indebtedness ?? 0} LYD',
                  balance <= 300
                      ? AppColors.primaryRed
                      : AppColors.primarySuccess,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _balanceChip(
                  'Indebtedness'.tr(),
                  '${item.balance ?? 0} LYD',
                  balance >= 1000
                      ? AppColors.primaryRed
                      : AppColors.primarySuccess,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primarySecondaryElementText)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.primaryText,
                )),
          ),
        ],
      ),
    );
  }

  Widget _balanceChip(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11.sp, color: color)),
          SizedBox(height: 2.h),
          Text(value,
              style: TextStyle(
                  fontSize: 14.sp, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

// ─── Edit form ─────────────────────────────────────────────
class EditFormCard extends StatelessWidget {
  final SalePointData item;
  final TextEditingController firstNameCtrl;
  final TextEditingController middleNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController businessNameCtrl;
  final TextEditingController machineNumberCtrl;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  const EditFormCard({
    Key? key,
    required this.item,
    required this.firstNameCtrl,
    required this.middleNameCtrl,
    required this.lastNameCtrl,
    required this.businessNameCtrl,
    required this.machineNumberCtrl,
    required this.onSaved,
    required this.onCancel,
  }) : super(key: key);

  InputDecoration _inputDec(String label) => InputDecoration(
        isDense: true,
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.w)),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.primaryFourElementText,
        border:
            Border.all(color: AppColors.primaryThreeElementText, width: 1.h),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Sale Point'.tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: AppColors.primaryText)),
          SizedBox(height: 10.h),
          TextField(
              controller: businessNameCtrl,
              decoration: _inputDec('Business Name'.tr())),
          SizedBox(height: 8.h),
          Row(children: [
            Expanded(
                child: TextField(
                    controller: firstNameCtrl,
                    decoration: _inputDec('First Name'.tr()))),
            SizedBox(width: 8.w),
            Expanded(
                child: TextField(
                    controller: middleNameCtrl,
                    decoration: _inputDec('Middle Name'.tr()))),
          ]),
          SizedBox(height: 8.h),
          Row(children: [
            Expanded(
                child: TextField(
                    controller: lastNameCtrl,
                    decoration: _inputDec('Last Name'.tr()))),
            SizedBox(width: 8.w),
            Expanded(
                child: TextField(
                    controller: machineNumberCtrl,
                    decoration: _inputDec('Machine Number'.tr()))),
          ]),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryElement,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w)),
                  ),
                  onPressed: () => _save(context),
                  child: Text('Save'.tr(),
                      style: TextStyle(color: AppColors.primaryBackground)),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w)),
                  ),
                  onPressed: onCancel,
                  child: Text('Cancel'.tr()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _save(BuildContext context) async {
    Loading.show();
    try {
      final res = await SalePointAPI.salePointDataUpdate(
        params: SalePointDataUpdateRequestEntity(
          id: item.id,
          firstName: firstNameCtrl.text,
          middleName: middleNameCtrl.text,
          lastName: lastNameCtrl.text,
          businessName: businessNameCtrl.text,
          machineNumber: machineNumberCtrl.text,
        ),
      );
      if (res.code == 0) {
        Loading.toast('Saved'.tr());
        onSaved();
      } else {
        Loading.toast(res.msg ?? 'Error'.tr());
      }
    } catch (e) {
      Loading.toast('Error'.tr());
    } finally {
      Loading.dismiss();
    }
  }
}

// ─── Action buttons grid ───────────────────────────────────
class ActionButtonsGrid extends StatelessWidget {
  final SalePointData item;
  final bool isEditing;
  final VoidCallback onToggleEdit;
  final VoidCallback? onStatusChanged;

  const ActionButtonsGrid({
    Key? key,
    required this.item,
    required this.isEditing,
    required this.onToggleEdit,
    this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = item.status == 1;

    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        _ActionButton(
          icon: isEditing ? Icons.close : Icons.edit,
          label: isEditing ? 'Cancel'.tr() : 'Edit'.tr(),
          color: isEditing ? AppColors.primaryRed : AppColors.primaryElement,
          onTap: onToggleEdit,
        ),
        _ActionButton(
          icon: isActive ? Icons.block : Icons.check_circle_outline,
          label: (isActive ? 'Deactivate' : 'Activate').tr(),
          color: isActive ? Colors.orange : AppColors.primarySuccess,
          onTap: () => _toggleStatus(context),
        ),
        _ActionButton(
          icon: Icons.chat_bubble_outline,
          label: 'Chat'.tr(),
          color: AppColors.primaryElement,
          onTap: () => _goChat(context),
        ),
        _ActionButton(
          icon: Icons.lock_reset,
          label: 'Reset Password'.tr(),
          color: Colors.deepOrange,
          onTap: () => _resetPassword(context),
        ),
        _ActionButton(
          icon: Icons.wallet,
          label: 'Wallet Password'.tr(),
          color: Colors.teal,
          onTap: () => _showWalletPassword(context),
        ),
        _ActionButton(
          icon: Icons.delete,
          label: 'Delete'.tr(),
          color: Colors.redAccent,
          onTap: () => _deleteSalePoint(context),
        ),
      ],
    );
  }

  void _deleteSalePoint(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete'.tr()),
        content: Text('Are you sure you want to delete this sale point?'.tr()),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('Cancel'.tr())),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete'.tr(),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    Loading.show();
    try {
      final res = await SalePointAPI.deleteSalePoint(
        params: SalePointIdRequestEntity(
          salePointId: item.id,
        ),
      );
      if (res.code == 0) {
        Loading.toast("Sale point deleted".tr());
        Navigator.of(context).pop(true);
      } else {
        Loading.toast(res.msg ?? 'Error'.tr());
      }
    } catch (e) {
      Loading.toast('Error'.tr());
    } finally {
      Loading.dismiss();
    }
  }

  void _toggleStatus(BuildContext context) async {
    final isActive = item.status == 1;
    final newStatus = isActive ? 2 : 1;
    Loading.show();
    try {
      final res = await SalePointAPI.salePointStatusUpdate(
        params: SalePointStatusUpdateRequestEntity(
          id: item.id,
          status: newStatus,
        ),
      );
      if (res.code == 0) {
        final toastMsg =
            isActive ? 'Deactivate request sent' : 'Activate request sent';
        Loading.toast(toastMsg.tr());
        item.status = newStatus;
        onStatusChanged?.call();
      } else {
        Loading.toast(res.msg ?? 'Error'.tr());
      }
    } catch (e) {
      Loading.toast('Error'.tr());
    } finally {
      Loading.dismiss();
    }
  }

  void _goChat(BuildContext context) async {
    if (item.token != null) {
      SqlDbService sqlDbService = await SqlDbService().init();
      var result = await sqlDbService.queryByTokenRow(item.token);
      ChatUserItem userItem = ChatUserItem();
      userItem.token = item.token;
      userItem.name = item.firstName;
      userItem.cid = item.cid ?? 0;
      userItem.avatar = item.avatar;
      userItem.msgNum = 0;
      userItem.lastMsg = 'no msg!';
      userItem.lastTime = '';
      if (result.isEmpty) {
        await sqlDbService.insertChatUser(userItem);
      }
      await Navigator.of(context)
          .pushNamed(AppRoutes.Chat, arguments: userItem);
    }
  }

  void _resetPassword(BuildContext context) async {
    // Show confirmation dialog first
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Reset Password'.tr()),
        content: Text(
            'Are you sure you want to reset the password for this sale point?'
                .tr()),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('Cancel'.tr())),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            onPressed: () => Navigator.pop(ctx, true),
            child:
                Text('Reset'.tr(), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    Loading.show();
    try {
      final res = await SalePointAPI.resetPassword(
        params: SalePointIdRequestEntity(salePointId: item.id),
      );
      if (res.code == 0) {
        final walletPwd = res.newPassword ?? '';
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('New Password'.tr()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText(
                  walletPwd,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 12.h),
                OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: walletPwd));
                    Loading.toast('Copied'.tr());
                  },
                  icon: const Icon(Icons.copy),
                  label: Text('Copy'.tr()),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Close'.tr())),
            ],
          ),
        );
      } else {
        Loading.toast(res.msg ?? 'Error'.tr());
      }
    } catch (e) {
      Loading.toast('Error'.tr());
    } finally {
      Loading.dismiss();
    }
  }

  void _showWalletPassword(BuildContext context) async {
    Loading.show();
    try {
      final res = await SalePointAPI.getWalletPassword(
        params: SalePointIdRequestEntity(salePointId: item.id),
      );
      if (res.code == 0) {
        final walletPwd = res.walletPassword ?? '';
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Wallet Password'.tr()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText(
                  walletPwd,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 12.h),
                OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: walletPwd));
                    Loading.toast('Copied'.tr());
                  },
                  icon: const Icon(Icons.copy),
                  label: Text('Copy'.tr()),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Close'.tr())),
            ],
          ),
        );
      } else {
        Loading.toast(res.msg ?? 'Error'.tr());
      }
    } catch (e) {
      Loading.toast('Error'.tr());
    } finally {
      Loading.dismiss();
    }
  }
}

// ─── Single action button ──────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 26.sp),
            SizedBox(height: 6.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
