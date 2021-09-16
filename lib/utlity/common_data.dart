  import 'package:mask_free/model/center_model.dart';
// stubs data file
class CommonData {
  static List<String> allDiseases = [
    'مرض الربو',
    'السكري',
    'الضغط',
    'مرض القلب',
    'امراض الكلى',
  ];
  static List <String> allGenders = [
    'ذكر',
    'انثى',
  ];
  static List<String> allDays = [
    'السبت',
    'الاحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
  ];
  static List<CenterModel> allCenters = [
    CenterModel(
      name: 'مركز الجلاء',
      location: [
        'دمشق',
        'المزرعة',
        'جانب جامع الايمان',
      ],
      phoneNumber: '09658324634',
      isAvailable: true
    ),
     CenterModel(
      name: 'مركز المهاجرين',
      location: [
        'دمشق',
        'المهاجرين',
        'جانب صيدلة اخر الخط',
      ],
      phoneNumber: '08239469328',
      isAvailable: true
    ),
        CenterModel(
      name: 'مركز البعث',
      location: [
        'حمص',
        'الدبلان',
        'اول الشارع',
      ],
      phoneNumber: '0847239863',
      isAvailable: true
    ),
        CenterModel(
      name: 'مركز الكفاءة',
      location: [
        'النبك',
        'ساحة المخرج',
        'مقابل شورما الزعيم',
      ],
      phoneNumber: '0938648334',
      isAvailable: false
    ),

  ];
  
  }
