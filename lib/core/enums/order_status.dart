import '../constant/app_constant.dart';

enum OrderStatus {
  received,
  hasBeenSent,
  preparing;

  factory OrderStatus.parse(String s) {
    if (s == AppConstant.received) {
      return OrderStatus.received;
    }
    if (s == AppConstant.has_been_sent) {
      return OrderStatus.hasBeenSent;
    }
    return OrderStatus.preparing;
  }
}
