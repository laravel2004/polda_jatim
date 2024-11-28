import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:monitor/models/general_response.dart';
import 'package:monitor/utils/data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkTransportService {
  final dio = Dio();

  Future<DataState<String>> getTransport() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final host = prefs.getString('host');
      final token = prefs.getString('token');
      final serverId = prefs.getString('serverId');
      final response = await dio.post(
        '$host/api_jsonrpc.php',
          data: {
          "jsonrpc": "2.0",
          "method": "item.get",
          "params": {
            "output": ["itemid", "name", "key_"],
            "hostids": serverId,
            "search": {
              "key_": "net.if.out"
            }
          },
          "auth": token,
          "id": 1
        }
      );
      final generalResponse = GeneralResponseModel.fromJsonList(response.data['result']);
      final targetItem = generalResponse.firstWhere(
            (item) => item.key == 'net.if.out["eth0"]',
      );
      return DataSuccess(targetItem.itemId!);
    } catch (e) {
      throw DataError(e.toString());
    }
  }
}