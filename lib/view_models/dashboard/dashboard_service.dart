import 'package:dio/dio.dart';
import 'package:monitor/models/error_logs_model.dart';
import 'package:monitor/models/interface_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  final dio = Dio();

  Future<List<InterfaceModel>> getInterfaces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final host = prefs.getString('host');
    final token = prefs.getString('token');
    final serverId = prefs.getString('serverId');

    final response = await dio.post(
      '$host/api_jsonrpc.php',
      data: {
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
          "hostids": serverId,
          "output": "extend",
          "selectInterfaces": "extend"
        },
        "auth": token,
        "id": 1
      },
    );

    return InterfaceModel.fromJsonList(response.data['result'][0]['interfaces']);
  }

  Future<List<ErrorLogsModel>> getErrorLogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final host = prefs.getString('host');
    final token = prefs.getString('token');
    final serverId = prefs.getString('serverId');

    final response = await dio.post(
      '$host/api_jsonrpc.php',
      data: {
        "jsonrpc": "2.0",
        "method": "event.get",
        "params": {
          "hostids": serverId,
          "output": "extend",
          "selectTags": "extend",
          "sortfield": ["clock"],
          "sortorder": "DESC"
        },
        "auth": token,
        "id": 1
      },
    );

    return ErrorLogsModel.fromJsonList(response.data['result']);
  }
}
