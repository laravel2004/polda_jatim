import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:monitor/models/general_response.dart';
import 'package:monitor/utils/data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkReceiveService {
  final dio = Dio();

  Future<DataState<String>> getReceive() async {
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
                "key_": "net.if.in"
              }
            },
            "auth": token,
            "id": 1
          }
      );
      print(response.data);
      final generalResponse = GeneralResponseModel.fromJsonList(response.data['result']);
      final targetItem = generalResponse.firstWhere(
            (item) => item.key == 'net.if.in["eth0"]',
      );
      debugPrint('test');
      return DataSuccess(targetItem.itemId!);
    } catch (e) {
      print(e.toString());
      return DataError(e.toString());
    }
  }
}