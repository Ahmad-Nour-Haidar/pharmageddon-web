import 'package:dartz/dartz.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class ReportsRemoteData {
  final _crud = AppInjection.getIt<CrudDio>();

  final r = {
    "status": 200,
    "data": {
      "orders": [
        {
          "id": 18,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 14,
          "total_price": 348033,
          "received_at": "2023-12-27T21:01:20+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T21:00:23+03:00"
        },
        {
          "id": 17,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 3,
          "total_price": 10500,
          "received_at": "2023-12-27T20:53:40+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:53:15+03:00"
        },
        {
          "id": 16,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 2,
          "total_price": 1800,
          "received_at": "2023-12-27T20:54:34+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:53:08+03:00"
        },
        {
          "id": 15,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 1,
          "total_price": 3500,
          "received_at": "2023-12-27T20:52:30+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:52:06+03:00"
        },
        {
          "id": 14,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 2,
          "total_price": 7000,
          "received_at": "2023-12-27T20:51:10+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:50:53+03:00"
        },
        {
          "id": 13,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 2,
          "total_price": 7000,
          "received_at": "2023-12-27T20:49:31+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:48:36+03:00"
        },
        {
          "id": 12,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 1,
          "total_price": 4500,
          "received_at": "2023-12-27T20:30:07+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:29:03+03:00"
        },
        {
          "id": 11,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 4,
          "total_price": 14000,
          "received_at": "2023-12-27T20:25:51+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:25:09+03:00"
        },
        {
          "id": 10,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 3,
          "total_price": 7500,
          "received_at": "2023-12-27T20:19:30+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T20:18:59+03:00"
        },
        {
          "id": 8,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 7,
          "total_price": 27500,
          "received_at": "2023-12-27T19:24:44+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T19:17:40+03:00"
        },
        {
          "id": 6,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 1,
          "total_price": 500,
          "received_at": "2023-12-27T17:43:52+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T17:42:56+03:00"
        },
        {
          "id": 5,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 32,
          "total_price": 100000,
          "received_at": "2023-12-27T16:29:29+03:00",
          "has_canceled": null,
          "created_at": "2023-12-27T16:18:45+03:00"
        },
        {
          "id": 4,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 38,
          "total_price": 123000,
          "received_at": "2023-12-27T16:10:48+03:00",
          "has_canceled": null,
          "created_at": "2023-12-25T07:42:38+03:00"
        },
        {
          "id": 3,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 1000,
          "total_price": 5000000,
          "received_at": "2023-12-27T16:16:10+03:00",
          "has_canceled": null,
          "created_at": "2023-12-24T21:26:32+03:00"
        },
        {
          "id": 2,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 15,
          "total_price": 52500,
          "received_at": "2023-12-27T16:08:07+03:00",
          "has_canceled": null,
          "created_at": "2023-12-24T10:17:55+03:00"
        },
        {
          "id": 1,
          "pharmacist_username": "ahmad nour haedr",
          "order_status": "received",
          "payment_status": 1,
          "total_quantity": 1000,
          "total_price": 3500000,
          "received_at": "2023-12-27T16:09:09+03:00",
          "has_canceled": null,
          "created_at": "2023-12-24T10:05:33+03:00"
        }
      ]
    },
    "message": {
      "custom_message": "Report orders retrieved successfully."
    }
  };

  Future<Either<ParentState, Map<String, dynamic>>> getReports({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user?.authorization!;
    // return Right(r);
    final response = await _crud.getData(
      linkUrl: AppLink.report,
      token: token,
      queryParameters: queryParameters,
    );
    return response;
  }
}
