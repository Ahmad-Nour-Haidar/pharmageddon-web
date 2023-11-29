import '../../model/user_model.dart';

class AppLocalData {
  AppLocalData._();

  static User? user;

  static const dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  static const dayNamesShort = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  static const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

// static final formatDate = DateFormat('EEEE, MMMM, yyyy - MM - dd');
// static final formatDate = DateFormat('yyyy MMMM EEEE d, MM');
// static final formatTime = DateFormat('hh:m a');

//   static final popupMenuItemsMonths = AppLocalData.monthNames
//       .map((month) => PopupMenuItemModel(value: month, text: month))
//       .toList();
//
//   static final popupMenuItemsHours = List.generate(12, (index) => index)
//       .map((index) =>
//           PopupMenuItemModel(value: '${index + 1}', text: '${index + 1}'))
//       .toList();
//
//   static final popupMenuItemsMinute = List.generate(61, (index) => index)
//       .map((index) => PopupMenuItemModel(value: '$index', text: '$index'))
//       .toList();
//
//   static final popupMenuItemsAmPm =
//       ['AM', 'PM'].map((e) => PopupMenuItemModel(value: e, text: e)).toList();
}
