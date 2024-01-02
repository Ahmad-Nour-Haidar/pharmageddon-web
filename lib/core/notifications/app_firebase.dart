import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmageddon_web/data/remote/auth_data.dart';
import 'package:pharmageddon_web/print.dart';
import '../../controllers/orders_cubit/orders_cubit.dart';
import '../constant/app_color.dart';
import '../constant/app_constant.dart';
import '../constant/app_keys_request.dart';
import '../services/dependency_injection.dart';

abstract class AppFirebase {
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    printme.cyan('================== onBackgroundMessage ================');
    printme.cyan('title = ${message.notification?.title}');
    printme.cyan('body = ${message.notification?.body}');
    printme.cyan('data = ${message.data}');
    printme.cyan('================== onBackgroundMessage ================');
    Map<String, dynamic> data = {};
    try {
      data = json.decode(message.data[AppRKeys.data]);
    } catch (_) {}
    final action = message.data[AppRKeys.action].toString();
    handleNotification(
      titleNotification: message.notification?.title,
      bodyNotification: message.notification?.body,
      data: data,
      action: action,
    );
    _handleActions(action, data);
  }

  static Future<void> firebaseMessaging(RemoteMessage message) async {
    printme.cyan('================== onMessage ================');
    printme.cyan('title = ${message.notification?.title}');
    printme.cyan('body = ${message.notification?.body}');
    printme.cyan('body = ${message.data}');
    printme.cyan('================== onMessage ================');

    Map<String, dynamic> data = {};
    try {
      data = json.decode(message.data[AppRKeys.data]);
    } catch (_) {}
    final action = message.data[AppRKeys.action].toString();
    handleNotification(
      titleNotification: message.notification?.title,
      bodyNotification: message.notification?.body,
      data: data,
      action: action,
    );
    _handleActions(action, data);
  }

  static Future<void> handleNotification({
    String? titleNotification,
    String? bodyNotification,
    String? action,
    Map<String, dynamic>? data,
  }) async {
    final title = titleNotification ?? 'Pharmageddon';
    var body = bodyNotification ?? 'New notification';
    if ((action == '1' ||
            action == '2' ||
            action == '3' ||
            action == '4' ||
            action == '6') &&
        data != null) {
      final orderId = data[AppRKeys.order_id];
      body = 'ID: $orderId , $body';
    }
    Fluttertoast.showToast(
      msg: '$title\n$body',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 20,
      // backgroundColor: AppColor.red,
      textColor: AppColor.white,
      fontSize: 16.0,
      webShowClose: true,
      webBgColor: "linear-gradient(to right, #EC00B8, #0000FF)",
      webPosition: "center",
    );
  }

  // 1 Create an order
  // 2 Modify an order
  // 3 Cancellation of a medication included in an order
  // 4 Cancel an order
  // 5 Send an order
  // 6 Receiving an order
  // 7 Pay an order
  // 8 Create a medicine
  static Future<void> _handleActions(
      String action, Map<String, dynamic>? data) async {
    if (action == '1' ||
        action == '2' ||
        action == '3' ||
        action == '4' ||
        action == '6') {
      AppInjection.getIt<OrdersCubit>().updateFromNotifications(
        action: action,
        orderId: data == null ? '0' : data[AppRKeys.order_id].toString(),
      );
    }
  }

  static Future<void> setToken() async {
    FirebaseMessaging.instance
        .getToken(vapidKey: AppConstant.keyPair)
        .then((token) {
      printme.yellow('------------------');
      printme.yellow(token);
      printme.yellow('------------------');
      if (token != null) {
        AppInjection.getIt<AuthRemoteData>().saveToken(token).then((value) {
          value.fold((l) {
            // printme.printFullText(l);
          }, (r) {
            // printme.printFullText(r);
          });
        }).catchError((e) {});
      }
    }).catchError((e) {});

    /// stream
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      // printme.yellow('------------------');
      // printme.yellow(token);
      // printme.yellow('------------------');
      AppInjection.getIt<AuthRemoteData>().saveToken(token).then((value) {
        value.fold((l) {
          // printme.printFullText(l);
        }, (r) {
          // printme.printFullText(r);
        });
      }).catchError((e) {});
    });
  }

  // when logout
  static Future<void> deleteTopics() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      printme.red(e);
    }
  }
}
