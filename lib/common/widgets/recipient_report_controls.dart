import 'package:app/common/utils/recipient_report.dart';
import 'package:app/common/utils/utils.dart';
import 'package:app/common/values/values.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipientReportControls extends StatelessWidget {
  const RecipientReportControls(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.totalAmount,
      required this.isLoading,
      required this.isPrinting,
      required this.onDatesChanged,
      required this.onSearch,
      required this.onPrint});

  final String startDate, endDate, totalAmount;
  final bool isLoading, isPrinting;
  final void Function(String, String) onDatesChanged;
  final VoidCallback onSearch, onPrint;

  void _pick(BuildContext context, bool start) {
    FocusManager.instance.primaryFocus?.unfocus();
    final format = DateFormat('yyyy-MM-dd HH:mm:ss', 'en');
    final value = start ? startDate : endDate;
    final initial = value.isEmpty ? DateTime.now() : format.parseStrict(value);
    DatePicker.showDateTimePicker(context,
        currentTime: initial,
        locale: pickerLocaleFrom(context),
        onConfirm: (date) => onDatesChanged(
            start ? format.format(date) : startDate,
            start ? endDate : format.format(date)));
  }

  @override
  Widget build(BuildContext context) {
    final hasDates = startDate.isNotEmpty || endDate.isNotEmpty;
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (totalAmount.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            decoration: BoxDecoration(
              color: const Color(0xffF0FAF6),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xffD9EFE4)),
            ),
            child: Column(children: [
              Text('Total Amount'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primaryFirstElementText)),
              SizedBox(height: 6.h),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.w,
                  children: [
                    Text(sumReportAmounts([totalAmount]),
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff15734E))),
                    Text('LYD',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff15734E))),
                  ]),
            ]),
          ),
          SizedBox(height: 22.h),
        ],
        Row(children: [
          Expanded(
              child: Text('Date range'.tr(),
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText))),
          if (hasDates)
            TextButton(
              onPressed: () => onDatesChanged('', ''),
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryElement,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500)),
              child: Text('Clear dates'.tr()),
            )
          else
            Text('All history'.tr(),
                style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primarySecondaryElementText)),
        ]),
        SizedBox(height: 10.h),
        LayoutBuilder(builder: (context, constraints) {
          final stacked = constraints.maxWidth < 270 ||
              MediaQuery.textScalerOf(context).scale(1) > 1.4;
          final fields = [
            for (final start in [true, false])
              _ReportDateField(
                  key: ValueKey(start ? 'report-date-from' : 'report-date-to'),
                  label: (start ? 'From' : 'To').tr(),
                  semanticLabel:
                      (start ? 'Select date from' : 'Select date to').tr(),
                  value: start ? startDate : endDate,
                  onTap: () => _pick(context, start)),
          ];
          if (stacked) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [fields[0], SizedBox(height: 12.h), fields[1]]);
          }
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: fields[0]),
            SizedBox(width: 12.w),
            Expanded(child: fields[1]),
          ]);
        }),
        SizedBox(height: 22.h),
        _ReportAction(
            label: 'Search'.tr(),
            icon: Icons.search_rounded,
            loading: isLoading,
            primary: true,
            onPressed: onSearch),
        SizedBox(height: 12.h),
        _ReportAction(
            label: 'PDF Print'.tr(),
            icon: Icons.picture_as_pdf_outlined,
            loading: isPrinting,
            primary: false,
            onPressed: onPrint),
      ]),
    );
  }
}

class _ReportDateField extends StatelessWidget {
  const _ReportDateField(
      {super.key,
      required this.label,
      required this.semanticLabel,
      required this.value,
      required this.onTap});
  final String label, semanticLabel, value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final parts = value.split(' ');
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: const Color(0xffF5F8FE),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
                color: value.isEmpty
                    ? const Color(0xffDCE5F2)
                    : AppColors.primaryElement)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 18.sp, color: AppColors.primaryElement),
                      SizedBox(width: 8.w),
                      Expanded(
                          child: Text(label,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryElement))),
                    ]),
                    SizedBox(height: 12.h),
                    Text(value.isEmpty ? 'Select date'.tr() : parts.first,
                        textDirection: value.isEmpty ? null : TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: value.isEmpty
                                ? AppColors.primaryFirstElementText
                                : AppColors.primaryText)),
                    SizedBox(height: 3.h),
                    Text(parts.length > 1 ? parts[1] : '--:--',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primarySecondaryElementText)),
                  ])),
        ),
      ),
    );
  }
}

class _ReportAction extends StatelessWidget {
  const _ReportAction(
      {required this.label,
      required this.icon,
      required this.loading,
      required this.primary,
      required this.onPressed});
  final String label;
  final IconData icon;
  final bool loading, primary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final foreground = primary ? Colors.white : AppColors.primaryElement;
    final background = primary ? AppColors.primaryElement : Colors.white;
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: background,
        foregroundColor: foreground,
        disabledBackgroundColor: background.withValues(alpha: .65),
        disabledForegroundColor: foreground,
        minimumSize: Size(double.infinity, 48.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(
                color: AppColors.primaryElement
                    .withValues(alpha: primary ? 0 : .4))),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (loading)
          SizedBox(
              width: 20.sp,
              height: 20.sp,
              child:
                  CircularProgressIndicator(strokeWidth: 2, color: foreground))
        else
          Icon(icon, size: 20.sp),
        SizedBox(width: 10.w),
        Flexible(
            child: Text(label,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600))),
      ]),
    );
  }
}
