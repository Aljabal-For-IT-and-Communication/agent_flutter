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
      _machineNumber =
          TextEditingController(text: _item.machineNumber ?? '');
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
                              onSaved: () {
                                setState(() {
                                  _item.firstName = _firstName.text;
                                  _item.middleName = _middleName.text;
                                  _item.lastName = _lastName.text;
                                  _item.businessName = _businessName.text;
                                  _item.machineNumber = _machineNumber.text;
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
