import 'package:get/get.dart';

import '../constant/app_text.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          AppText.language: 'Language',
          AppText.arabic: 'عربي',
          AppText.english: 'English',
          AppText.login: 'Login',
          AppText.createAccount: 'Create account',
          AppText.letGetStarted: 'Let\'s get started ...',
          AppText.email: 'Email',
          AppText.emailOrPhone: 'Email or Phone',
          AppText.emailOrPhoneNotValid: 'Email or Phone not valid',
          AppText.userName: 'User Name',
          AppText.phoneNumber: 'Phone Number',
          AppText.address: 'Address',
          AppText.password: 'Password',
          AppText.register: 'Register',
          AppText.edit: 'Edit',
          AppText.haveAnAccount: 'Have an account ?',
          AppText.loginNow: 'Login now',
          AppText.or: 'OR',
          AppText.thisFieldCantBeEmpty: 'This field can\'t be empty',
          AppText.lengthMustBeBetween: 'Length must be between',
          AppText.notValid: 'Not valid',
          AppText.emailMustBeEndWith: 'Email must be end with',
          AppText.phone: 'Phone',
          AppText.thePhoneNumberMustStartWith:
              'The phone number must start with 09 and have a total of 10 digits',
          AppText.passwordMustBeAtLeast8:
              'Password must be at least 8 characters and contain a mix of uppercase and lowercase letters, numbers, and special characters.',
          AppText.doNotHaveAnAccount: 'Don\'t have an account ?',
          AppText.thereIsAlreadyAnAccountForTheWarehouseOwner:
              'There is already an account for the warehouse owner.',
          AppText.passwordNotCorrect: 'Password not correct',
          AppText.userNotFound: 'User not found',
          AppText.verifyCodeNotCorrect: 'Verify code not correct',
          AppText.verifyCodeNotSentTryAgain: 'Verify code not sent, Try again!',
          AppText.goToTheOtherPlatform: 'Go to the other platform',
          AppText.resendVerifyCode: 'Resend verify code',
          AppText.emailOrPasswordIsWrong: 'Email or password is wrong.',
          AppText.forgetPassword: 'Forget Password',
          AppText.check: 'Check',
          AppText.checkEmail: 'Check email',
          AppText.reset: 'Reset',
          AppText.resetPassword: 'Reset Password',
          AppText.confirm: 'Confirm',
          AppText.passwordsNoMatch: 'Passwords No Match',
          AppText.somethingWentWrong: 'Something went wrong',
          AppText.welcomeBack: 'Welcome Back',
          AppText.name: 'Name',
          AppText.youAreOffline: 'You are offline',
          AppText.field: 'Field',
          AppText.alreadyBeenTaken: 'already been taken.',
          AppText.enterTheVerificationCodeYouReceivedOnGmail:
              'Enter the verification code you received on Gmail',
          AppText.enterTheCompleteVerificationCode:
              'Enter the complete verification code.',
          AppText.verify: 'Verify',
          AppText.verifyCode: 'Verify Code',
          AppText.price: 'Price',
          AppText.totalPrice: 'Total Price',
          AppText.addToCart: 'Add to cart',
          AppText.done: 'Done',
          AppText.manufacturer: 'Manufacturer',
          AppText.category: 'Category',
          AppText.home: 'Home',
          AppText.profile: 'Profile',
          AppText.favorite: 'Favorite',
          AppText.myOrders: 'My Orders',
          AppText.logOut: 'Log Out',
          AppText.doYouWantToLogOut: 'Do you want to log out?',
          AppText.yes: 'Yes',
          AppText.no: 'No',
          AppText.pressBackAgainToExit: 'Press back again to exit',
          AppText.youHaveNoFoodsFavoriteYet: 'You have no foods favorite yet',
          AppText.resultsSearchFor: 'Results search for',
          AppText.openInFullScreen: 'Open in full screen',
          AppText.all: 'All',

        },
        'ar': {
          AppText.manufacturer: 'شركات مصنعة',
          AppText.category: 'فئات',
          AppText.all: 'الكل',
          AppText.language: 'اللغة',
          AppText.arabic: 'عربي',
          AppText.english: 'English',
          AppText.login: 'تسجيل الدخول',
          AppText.createAccount: 'انشاء حساب',
          AppText.letGetStarted: 'دعنا نبدأ ...',
          AppText.email: 'البريد الإلكتروني',
          AppText.emailOrPhone: 'البريد الإلكتروني او رقم الهاتف',
          AppText.emailOrPhoneNotValid:
              'البريد الإلكتروني او رقم الهاتف غير صالح',
          AppText.userName: 'اسم المستخدم',
          AppText.phoneNumber: 'رقم الهاتف',
          AppText.address: 'العنوان',
          AppText.password: 'كلمة المرور',
          AppText.register: 'سجل',
          AppText.edit: 'تعديل',
          AppText.haveAnAccount: 'لديك حساب ؟',
          AppText.loginNow: 'سجل الآن',
          AppText.or: 'او',
          AppText.thisFieldCantBeEmpty: 'هذا الحقل لا يمكن ان يكون فارغا',
          AppText.lengthMustBeBetween: 'يجب أن يكون الطول بين',
          AppText.notValid: 'غير صالح',
          AppText.emailMustBeEndWith: 'يجب أن ينتهي البريد الإلكتروني بـ',
          AppText.phone: 'رقم الهاتف',
          AppText.thePhoneNumberMustStartWith:
              'يجب أن يبدأ رقم الهاتف بالرقم 09 وأن يتكون من 10 أرقام',
          AppText.passwordMustBeAtLeast8:
              'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل وأن تحتوي على مزيج من الأحرف الكبيرة والصغيرة والأرقام والأحرف الخاصة.',
          AppText.thereIsAlreadyAnAccountForTheWarehouseOwner:
              'يوجد بالفعل حساب لصاحب المستودع.',
          AppText.passwordNotCorrect: 'كلمة المرور غير صحيحة',
          AppText.userNotFound: 'لم يتم العثور على المستخدم',
          AppText.verifyCodeNotCorrect: 'رمز التحقق غير صحيح',
          AppText.verifyCodeNotSentTryAgain:
              'لم يتم إرسال رمز التحقق، حاول مرة أخرى!',
          AppText.goToTheOtherPlatform: 'انتقل إلى المنصة الأخرى',
          AppText.check: 'تحقق',
          AppText.checkEmail: 'فحص البريد الإلكتروني',
          AppText.reset: 'إعادة ضبط',
          AppText.verify: 'تحقق',
          AppText.verifyCode: 'التحقق من الكود',
          AppText.resetPassword: 'إعادة تعيين كلمة المرور',
          AppText.confirm: 'تأكيد',
          AppText.passwordsNoMatch: 'كلمات المرور غير متطابقة',
          AppText.somethingWentWrong: 'هناك خطأ ما',
          AppText.name: 'الاسم',
          AppText.welcomeBack: 'اهلا بعودتك',
          AppText.forgetPassword: 'نسيت كلمة المرور',
          AppText.resendVerifyCode: 'إعادة إرسال رمز التحقق',
          AppText.emailOrPasswordIsWrong:
              'البريد الإلكتروني أو كلمة المرور خاطئة.',
          AppText.doNotHaveAnAccount: 'ليس لديك حساب ؟',
          AppText.field: 'حقل',
          AppText.alreadyBeenTaken: 'بالفعل تم اخذها.',
          AppText.enterTheVerificationCodeYouReceivedOnGmail:
              'أدخل رمز التحقق الذي تلقيته على Gmail',
          AppText.enterTheCompleteVerificationCode: 'ادخل كامل رمز التحقق.',
          AppText.price: 'السعر',
          AppText.totalPrice: 'السعر الاجمالي',
          AppText.addToCart: 'اضف الى السلة',
          AppText.done: 'تم',
          AppText.home: 'الرئيسية',
          AppText.profile: 'الملف الشخصي',
          AppText.favorite: 'المفضلة',
          AppText.myOrders: 'طلباتي',
          AppText.logOut: 'تسجيل الخروج',
          AppText.doYouWantToLogOut: 'هل تريد تسجيل خروج ؟',
          AppText.yes: 'نعم',
          AppText.no: 'لا',
          AppText.pressBackAgainToExit: 'اضغط مرة أخرى للخروج',
          AppText.youHaveNoFoodsFavoriteYet: 'ليس لديك أي أطعمة مفضلة حتى الآن',
          AppText.resultsSearchFor: 'نتائج البحث عن',
          AppText.openInFullScreen: 'فتح في وضع ملء الشاشة',
        },
      };
}
