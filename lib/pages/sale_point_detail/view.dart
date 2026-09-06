import 'package:app/common/entities/entities.dart';
import 'package:app/common/values/values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget.dart';

class SalePointDetailPage extends StatefulWidget {
  const SalePointDetailPage({Key? key}) : super(key: key);

  @override
  State<SalePointDetailPage> createState() => _SalePointDetailPageState();
}

class _SalePointDetailPageState extends State<SalePointDetailPage> {
  late SalePointData _item;
  bool _isEditing = false;

  late TextEditingController _firstName;
  late TextEditingController _middleName;
  late TextEditingController _lastName;
  late TextEditingController _businessName;
  late TextEditingController _machineNumber;
  late TextEditingController _address;

  bool _didInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInit) {
      _item = ModalRoute.of(context)!.settings.arguments as SalePointData;
      _firstName = TextEditingController(text: _item.firstName ?? '');
      _middleName = TextEditingController(text: _item.middleName ?? '');
      _lastName = TextEditingController(text: _item.lastName ?? '');
      _businessName = TextEditingController(text: _item.businessName ?? '');
      _machineNumber = TextEditingController(text: _item.machineNumber ?? '');
      _address = TextEditingController(text: _item.address ?? '');
      _didInit = true;
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _businessName.dispose();
    _machineNumber.dispose();
    _address.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      if (_isEditing) {
        // Reset controllers on cancel
        _firstName.text = _item.firstName ?? '';
        _middleName.text = _item.middleName ?? '';
        _lastName.text = _item.lastName ?? '';
        _businessName.text = _item.businessName ?? '';
        _machineNumber.text = _item.machineNumber ?? '';
        _address.text = _item.address ?? '';
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final balance = double.tryParse(_item.balance ?? '0') ?? 0;

    return Scaffold(
      body: Container(
        color: AppColors.primaryBackground,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: DetailAppBar(item: _item)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Info card
                    SalePointInfoCard(item: _item, balance: balance),
                    SizedBox(height: 16.h),

                    // Edit section
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: _isEditing
                          ? EditFormCard(
                              item: _item,
                              firstNameCtrl: _firstName,
                              middleNameCtrl: _middleName,
                              lastNameCtrl: _lastName,
                              businessNameCtrl: _businessName,
                              machineNumberCtrl: _machineNumber,
                              addressCtrl: _address,
                              onSaved: (savedItem) {
                                setState(() {
                                  _item.firstName = savedItem.firstName;
                                  _item.middleName = savedItem.middleName;
                                  _item.lastName = savedItem.lastName;
                                  _item.businessName = savedItem.businessName;
                                  _item.machineNumber = savedItem.machineNumber;
                                  _item.address = savedItem.address;
                                  _item.avatar = savedItem.avatar;
                                  _isEditing = false;
                                });
                              },
                              onCancel: _toggleEditing,
                            )
                          : const SizedBox.shrink(),
                    ),

                    // Action buttons
                    SizedBox(height: 8.h),
                    Text(
                      'Actions'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.primaryText,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ActionButtonsGrid(
                      item: _item,
                      isEditing: _isEditing,
                      onToggleEdit: _toggleEditing,
                      onStatusChanged: () {
                        setState(() {});
                      },
                      onTransactionResult: (result) {
                        final type = result['type'] as String?;
                        final amount =
                            double.tryParse(result['amount'] ?? '') ?? 0;
                        if (amount == 0) return;

                        setState(() {
                          final currentBalance =
                              double.tryParse(_item.balance ?? '0') ?? 0;
                          final currentIndebtedness =
                              double.tryParse(_item.indebtedness ?? '0') ?? 0;

                          if (type == 'recharge') {
                            _item.balance =
                                (currentBalance + amount).toStringAsFixed(2);
                            _item.indebtedness = (currentIndebtedness + amount)
                                .toStringAsFixed(2);
                          } else if (type == 'retrack') {
                            _item.balance =
                                (currentBalance - amount).toStringAsFixed(2);
                            _item.indebtedness = (currentIndebtedness - amount)
                                .toStringAsFixed(2);
                          } else if (type == 'collect') {
                            _item.balance =
                                (currentBalance - amount).toStringAsFixed(2);
                          }
                        });
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
