import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/reports_cubit/reports_state.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/print.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_text.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/reports_data.dart';
import '../../model/order_model.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitialState());

  static ReportsCubit get(BuildContext context) => BlocProvider.of(context);
  final _reportsRemoteData = AppInjection.getIt<ReportsRemoteData>();
  final List<OrderModel> data = [];
  var dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  void _update(ReportsState state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> getData() async {
    if (dateTimeRange.duration.inDays == 0) {
      _update(ReportsFailureState(
          WarningState(message: AppText.pleaseSelectStartAndEndOfDate.tr)));
      return;
    }
    _update(ReportsLoadingState());
    final queryParameters = {
      AppRKeys.start_date: dateTimeRange.start,
      AppRKeys.end_date: dateTimeRange.end,
    };
    final response =
        await _reportsRemoteData.getReports(queryParameters: queryParameters);
    response.fold((l) {
      _update(ReportsFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 403) {
        data.clear();
      } else {
        final List temp = r[AppRKeys.data][AppRKeys.orders];
        data.clear();
        data.addAll(temp.map((e) => OrderModel.fromJson(e)));
        printData();
      }
      _update(ReportsSuccessState());
    });
  }

  void printData() {
    final Map<String, double> re = {};
    for (final e in data) {
      final date = formatYYYYMd(e.createdAt);
      final x = e.totalPrice ?? 0.0;
      final old = re[date] ?? 0.0;
      re[date] = old + x;
    }
    for (final e in re.entries) {
      printme.blue('${e.key} : ${e.value}');
    }
  }

  void setDateTimeRange(DateTimeRange dateTimeRange) {
    this.dateTimeRange = dateTimeRange;
    _update(ReportsChangeState());
  }

  int get totalQuantity {
    int q = 0;
    for (final element in data) {
      q += element.totalQuantity!;
    }
    return q;
  }

  double get totalPrice {
    double p = 0.0;
    for (final element in data) {
      p += element.totalPrice!;
    }
    return p;
  }
}
