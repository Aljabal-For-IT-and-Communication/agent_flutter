import 'package:app/common/apis/apis.dart';
import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/i18n.dart';
import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:app/common/widgets/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthorizedDevicesPage extends StatefulWidget {
  const AuthorizedDevicesPage({super.key});

  @override
  State<AuthorizedDevicesPage> createState() => _AuthorizedDevicesPageState();
}

class _AuthorizedDevicesPageState extends State<AuthorizedDevicesPage> {
  List<AgentDeviceData> _devices = const [];
  bool _isLoading = true;
  int? _actionDeviceId;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }
    try {
      final result = await UserAPI.deviceList();
      if (!mounted) return;
      if (result.code == 0) {
        setState(() {
          _devices = result.data ?? const [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _devices = const [];
          _isLoading = false;
          _errorMessage = trServerMessage('${result.msg}');
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _devices = const [];
        _isLoading = false;
        _errorMessage = 'internet error'.tr();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: RefreshIndicator(
        onRefresh: _loadDevices,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: BuildPublicAppBar(title: 'Authorized Devices'.tr()),
            ),
            if (_isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_errorMessage != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _MessageState(
                  icon: Icons.error_outline_rounded,
                  message: _errorMessage!,
                  actionLabel: 'Retry'.tr(),
                  onAction: _loadDevices,
                ),
              )
            else if (_devices.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _MessageState(
                  icon: Icons.devices_other_rounded,
                  message: 'No devices found'.tr(),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final device = _devices[index];
                      return _DeviceCard(
                        device: device,
                        isActionLoading: _actionDeviceId == device.id,
                        onAuthorize: () => _authorize(device),
                        onDeny: () => _confirmDeny(device),
                        onRevoke: () => _confirmRevoke(device),
                      );
                    },
                    childCount: _devices.length,
                  ),
                ),
              ),
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          ],
        ),
      ),
    );
  }

  Future<void> _authorize(AgentDeviceData device) {
    return _submitAction(
      device,
      (params) => UserAPI.authorizeDevice(params: params),
      'Device authorized'.tr(),
    );
  }

  Future<void> _confirmDeny(AgentDeviceData device) async {
    final confirmed = await _showConfirmation(
      title: 'Deny device'.tr(),
      message: 'Deny device confirmation'.tr(),
      confirmLabel: 'Deny'.tr(),
    );
    if (!confirmed) return;
    await _submitAction(
      device,
      (params) => UserAPI.denyDevice(params: params),
      'Device denied'.tr(),
    );
  }

  Future<void> _confirmRevoke(AgentDeviceData device) async {
    final confirmed = await _showConfirmation(
      title: 'Revoke device'.tr(),
      message: 'Revoke device confirmation'.tr(),
      confirmLabel: 'Revoke'.tr(),
    );
    if (!confirmed) return;
    await _submitAction(
      device,
      (params) => UserAPI.revokeDevice(params: params),
      'Device revoked'.tr(),
    );
  }

  Future<bool> _showConfirmation({
    required String title,
    required String message,
    required String confirmLabel,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text('Cancel'.tr()),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(confirmLabel),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _submitAction(
    AgentDeviceData device,
    Future<dynamic> Function(AgentDeviceActionRequestEntity params) request,
    String successMessage,
  ) async {
    final id = device.id;
    if (id == null || _actionDeviceId != null) return;
    setState(() => _actionDeviceId = id);
    try {
      final result = await request(AgentDeviceActionRequestEntity(id: id));
      if (!mounted) return;
      if (result.code == 0) {
        toastInfo(msg: successMessage);
        await _loadDevices();
      } else {
        toastInfo(msg: trServerMessage('${result.msg}'));
      }
    } catch (_) {
      if (mounted) toastInfo(msg: 'internet error'.tr());
    } finally {
      if (mounted) setState(() => _actionDeviceId = null);
    }
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.device,
    required this.isActionLoading,
    required this.onAuthorize,
    required this.onDeny,
    required this.onRevoke,
  });

  final AgentDeviceData device;
  final bool isActionLoading;
  final VoidCallback onAuthorize;
  final VoidCallback onDeny;
  final VoidCallback onRevoke;

  @override
  Widget build(BuildContext context) {
    final status = (device.status ?? 'pending').toLowerCase();
    final isMain = device.isMainDevice == true;
    final canAuthorize = !isMain &&
        (status == 'pending' || status == 'denied' || status == 'revoked');
    final canDeny = !isMain && status == 'pending';
    final canRevoke = !isMain && status == 'authorized';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.primarySecondaryBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  device.platform == 'ios'
                      ? Icons.phone_iphone_rounded
                      : Icons.phone_android_rounded,
                  color: AppColors.primaryB,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _deviceTitle,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        _StatusBadge(status: status),
                        if (isMain)
                          _StatusBadge(
                            status: 'main',
                            label: 'Main device'.tr(),
                            color: AppColors.primaryElement,
                          ),
                        if (device.isCurrentDevice == true)
                          _StatusBadge(
                            status: 'current',
                            label: 'Current device'.tr(),
                            color: AppColors.primaryA,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _InfoLine(label: 'Platform and model'.tr(), value: _platformModel),
          _InfoLine(
            label: 'Requested at'.tr(),
            value: _formatDate(context, device.requestedAt),
          ),
          _InfoLine(
            label: 'Last login'.tr(),
            value: _formatDate(context, device.lastLoginAt),
          ),
          if (!isMain && (canAuthorize || canDeny || canRevoke)) ...[
            SizedBox(height: 8.h),
            if (isActionLoading)
              SizedBox(
                height: 36.h,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  if (canAuthorize)
                    _ActionButton(
                      label: 'Authorize'.tr(),
                      icon: Icons.verified_user_outlined,
                      color: AppColors.primarySuccess,
                      onTap: onAuthorize,
                    ),
                  if (canDeny)
                    _ActionButton(
                      label: 'Deny'.tr(),
                      icon: Icons.close_rounded,
                      color: AppColors.primaryWarning,
                      onTap: onDeny,
                    ),
                  if (canRevoke)
                    _ActionButton(
                      label: 'Revoke'.tr(),
                      icon: Icons.block_rounded,
                      color: AppColors.primaryError,
                      onTap: onRevoke,
                    ),
                ],
              ),
          ],
        ],
      ),
    );
  }

  String get _deviceTitle {
    final name = (device.deviceName ?? '').trim();
    if (name.isNotEmpty) return name;
    return _platformModel == '-' ? 'Unknown device'.tr() : _platformModel;
  }

  String get _platformModel {
    final parts = [device.platform, device.manufacturer, device.model]
        .map((value) => value?.trim() ?? '')
        .where((value) => value.isNotEmpty)
        .toList();
    return parts.isEmpty ? '-' : parts.join(' - ');
  }

  String _formatDate(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) return '-';
    final parsed = DateTime.tryParse(value)?.toLocal();
    if (parsed == null) return value;
    return DateFormat('yyyy/MM/dd HH:mm', 'en_US').format(parsed);
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112.w,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.primarySecondaryElementText,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, this.label, this.color});

  final String status;
  final String? label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? _statusColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label ?? _statusLabel,
        style: TextStyle(
          color: badgeColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String get _statusLabel {
    switch (status) {
      case 'authorized':
        return 'Authorized'.tr();
      case 'denied':
        return 'Denied'.tr();
      case 'revoked':
        return 'Revoked'.tr();
      default:
        return 'Pending'.tr();
    }
  }

  Color get _statusColor {
    switch (status) {
      case 'authorized':
        return AppColors.primarySuccess;
      case 'denied':
      case 'revoked':
        return AppColors.primaryError;
      default:
        return AppColors.primaryWarning;
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 17.sp),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 56.sp, color: AppColors.primarySecondaryElementText),
            SizedBox(height: 14.h),
            Text(message, textAlign: TextAlign.center),
            if (onAction != null) ...[
              SizedBox(height: 12.h),
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
