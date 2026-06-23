import 'package:app/common/values/values.dart';
import 'package:app/common/widgets/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final sections = isArabic ? _arabicSections : _englishSections;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BuildPublicAppBar(title: "Privacy Policy".tr()),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final section = sections[index];
                  return _PolicySection(
                    title: section.title,
                    body: section.body,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  );
                },
                childCount: sections.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String body;
  final TextAlign textAlign;

  const _PolicySection({
    required this.title,
    required this.body,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: textAlign == TextAlign.right
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: textAlign,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            body,
            textAlign: textAlign,
            style: TextStyle(
              color: AppColors.primarySecondaryElementText,
              height: 1.55,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicyContent {
  final String title;
  final String body;

  const _PolicyContent(this.title, this.body);
}

const _englishSections = [
  _PolicyContent(
    'Overview',
    'Alafdal+ Agents is used by authorized agents to manage sale points, balances, collections, recharges, account reports, shipping operations, pending operations, and related validation workflows. This policy explains what information the app uses and why.',
  ),
  _PolicyContent(
    'Information We Use',
    'The app may use account information such as name, phone number, avatar, agent ID, sale point details, transaction records, balances, debts, reports, uploaded validation files, machine or barcode data, and app language settings. When you scan, upload, or attach files for validation, the selected photos or documents are sent only for that workflow.',
  ),
  _PolicyContent(
    'How We Use Information',
    'We use information to sign you in, show your profile and balance, create and review sale points, process collections and recharges, show pending operations, generate reports, validate transactions, prevent duplicate submissions, and provide support when you contact us.',
  ),
  _PolicyContent(
    'Notifications',
    'The app includes an in-app notification page where you can review account and operation updates related to your work.',
  ),
  _PolicyContent(
    'Device Permissions',
    'The app requests only the permissions needed for its features, such as camera access for scanning barcodes or capturing validation photos, and file or photo access when you choose to attach a document or image.',
  ),
  _PolicyContent(
    'Sharing and Storage',
    'Information is shared only with the Alafdal+ systems and authorized users needed to operate the service, process transactions, validate records, provide reports, or comply with legal and accounting requirements. We do not sell personal information.',
  ),
  _PolicyContent(
    'Security',
    'We use authentication, access controls, and operational safeguards to protect account and transaction data. You are responsible for keeping your login credentials secure and using the app only for authorized business activity.',
  ),
  _PolicyContent(
    'Retention',
    'Business, transaction, accounting, and validation records may be retained as needed for service operation, dispute review, audit, legal, tax, and accounting requirements. Other information is kept only as long as reasonably needed for the app and support workflows.',
  ),
  _PolicyContent(
    'Your Choices',
    'You can contact support to ask about your account information, request correction, or request account deletion. Some records may need to be retained when required for legal, accounting, audit, fraud-prevention, or transaction-history purposes.',
  ),
  _PolicyContent(
    'Contact',
    'For privacy questions or account requests, use the Contact Us page in the app.',
  ),
];

const _arabicSections = [
  _PolicyContent(
    'نظرة عامة',
    'يُستخدم تطبيق Alafdal+ Agents من قبل الوكلاء المصرح لهم لإدارة نقاط البيع والأرصدة والتحصيلات والشحنات وكشوف الحساب وعمليات الشحن والعمليات المعلقة وعمليات التحقق المرتبطة بها. توضح هذه السياسة المعلومات التي يستخدمها التطبيق وسبب استخدامها.',
  ),
  _PolicyContent(
    'المعلومات التي نستخدمها',
    'قد يستخدم التطبيق معلومات الحساب مثل الاسم ورقم الهاتف والصورة ومعرّف الوكيل وبيانات نقاط البيع وسجلات العمليات والأرصدة والمديونيات والتقارير وملفات التحقق المرفوعة وبيانات الأجهزة أو الباركود وإعدادات اللغة. عند المسح أو الرفع أو إرفاق ملف للتحقق، يتم إرسال الصور أو المستندات التي تختارها لهذا الغرض فقط.',
  ),
  _PolicyContent(
    'كيف نستخدم المعلومات',
    'نستخدم المعلومات لتسجيل الدخول وعرض الملف الشخصي والرصيد وإنشاء ومراجعة نقاط البيع ومعالجة التحصيلات والشحنات وعرض العمليات المعلقة وإنشاء التقارير والتحقق من العمليات ومنع التكرار وتقديم الدعم عند التواصل معنا.',
  ),
  _PolicyContent(
    'الإشعارات',
    'يتضمن التطبيق صفحة إشعارات داخلية يمكنك من خلالها مراجعة تحديثات الحساب والعمليات المرتبطة بعملك.',
  ),
  _PolicyContent(
    'صلاحيات الجهاز',
    'يطلب التطبيق الصلاحيات اللازمة لميزاته فقط، مثل الكاميرا لمسح الباركود أو التقاط صور التحقق، والوصول إلى الملفات أو الصور عند اختيار إرفاق مستند أو صورة.',
  ),
  _PolicyContent(
    'المشاركة والتخزين',
    'تتم مشاركة المعلومات فقط مع أنظمة Alafdal+ والمستخدمين المصرح لهم اللازمين لتشغيل الخدمة ومعالجة العمليات والتحقق من السجلات وتوفير التقارير أو الالتزام بالمتطلبات القانونية والمحاسبية. نحن لا نبيع المعلومات الشخصية.',
  ),
  _PolicyContent(
    'الأمان',
    'نستخدم تسجيل الدخول وضوابط الوصول وإجراءات تشغيلية لحماية بيانات الحساب والعمليات. أنت مسؤول عن الحفاظ على بيانات الدخول الخاصة بك واستخدام التطبيق فقط للأعمال المصرح بها.',
  ),
  _PolicyContent(
    'الاحتفاظ بالبيانات',
    'قد يتم الاحتفاظ بسجلات الأعمال والعمليات والمحاسبة والتحقق حسب الحاجة لتشغيل الخدمة ومراجعة النزاعات والتدقيق والمتطلبات القانونية والضريبية والمحاسبية. يتم الاحتفاظ بالمعلومات الأخرى فقط للمدة اللازمة بشكل معقول لتشغيل التطبيق وتقديم الدعم.',
  ),
  _PolicyContent(
    'خياراتك',
    'يمكنك التواصل مع الدعم للاستفسار عن معلومات حسابك أو طلب تصحيحها أو طلب حذف الحساب. قد يلزم الاحتفاظ ببعض السجلات عند الحاجة لأغراض قانونية أو محاسبية أو تدقيق أو منع الاحتيال أو سجل العمليات.',
  ),
  _PolicyContent(
    'التواصل',
    'لأسئلة الخصوصية أو طلبات الحساب، استخدم صفحة اتصل بنا داخل التطبيق.',
  ),
];
