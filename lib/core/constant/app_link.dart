abstract class AppLink {
  // http://127.0.0.1/api/auth/register

  // static const _host = '10.0.2.2:8000';

  // static const _host = 'localhost:8000';
  //
  // static const _host = '192.168.43.76:8000';
  //
  static const _host = 'pharmageddon-myproject.000webhostapp.com';

  static const _serverApi = 'https://$_host/api';

  static const _serverUpload = 'https://$_host';

  static const _serverImage = '$_serverUpload/images';

  // auth
  // http://10.0.2.2:8000/api/auth/register
  static const register = '$_serverApi/auth/register';
  static const sendVerificationCode = '$_serverApi/auth/send_verification_code';
  static const login = '$_serverApi/auth/login';
  static const checkVerifyCode = '$_serverApi/auth/check_verification_code';
  static const checkEmail = '$_serverApi/auth/check_user_if_exists';
  static const resetPassword = '$_serverApi/auth/reset_password';
  static const profile = '$_serverApi/auth/get_user_profile';
  static const logout = '$_serverApi/auth/logout';
  static const updateUser = '$_serverApi/user/update_user_profile';
  static const saveToken = '$_serverApi/save_token';
  static const userImage = '$_serverImage/users';

  // medicine
  static const medicineGetAll = '$_serverApi/medicine/get_all';
  static const medicineGetAllDiscount = '$_serverApi/medicine/get_all_discount';
  static const medicineGetAllDateExpired = '$_serverApi/medicine/date_expired';
  static const medicineGetAllQuantityExpired =
      '$_serverApi/medicine/quantity_expired';
  static const medicineUpdate = '$_serverApi/medicine/update';
  static const medicineDelete = '$_serverApi/medicine/delete';
  static const medicineCreate = '$_serverApi/medicine/create';
  static const medicineImage = '$_serverImage/medicines';

  // manufacturer
  static const manufacturerCreate = '$_serverApi/manufacturer/create';
  static const manufacturerUpdate = '$_serverApi/manufacturer/update';
  static const manufacturerGetAll = '$_serverApi/manufacturer/get_all_c';
  static const manufacturerGetAllM = '$_serverApi/manufacturer/get_all_m';
  static const manufacturerGetAllMedicines = '$_serverApi/class/manufacturer';

  // effect categories
  static const effectCategoriesCreate = '$_serverApi/effect_category/create';
  static const effectCategoriesUpdate = '$_serverApi/effect_category/update';
  static const effectCategoriesGetAll = '$_serverApi/effect_category/get_all_c';
  static const effectCategoriesGetAllM =
      '$_serverApi/effect_category/get_all_m';
  static const effectCategoriesGetAllMedicines =
      '$_serverApi/class/effect_category';
  static const effectCategoriesImage = '$_serverImage/effect_categories';

  // search
  static const search = '$_serverApi/search';

  // order
  static const order = '$_serverApi/order/create';
  static const orderUpdate = '$_serverApi/order/update';
  static const orderUpdateStatus = '$_serverApi/order/update_status';
  static const orderGetAll = '$_serverApi/order/get_all';
  static const orderGetAllNotCanceled =
      '$_serverApi/order/get_all_not_canceled';
  static const orderGetAllPreparing = '$_serverApi/order/get_all_preparing';
  static const orderGetAllSent = '$_serverApi/order/get_all_sent';
  static const orderGetAllReceived = '$_serverApi/order/get_all_received';
  static const orderGetOrderDetails = '$_serverApi/order/get';
  static const orderDelete = '$_serverApi/order/delete';
  static const orderDeleteMedicine = '$_serverApi/order/delete_medicine';
  static const orderUpdatePaymentStatus = '$_serverApi/order/has_been_paid';
  static const orderGetAllUnpaid = '$_serverApi/order/get_all_unpaid';
  static const orderGetAllPaid = '$_serverApi/order/get_all_paid';

  // report
  static const report = '$_serverApi/report';
}
