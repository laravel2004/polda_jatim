import 'package:dio/dio.dart';
import 'package:monitor/models/network.dart';
import 'package:monitor/utils/data_state.dart';
import 'package:monitor/view_models/network/network_receive.dart';
import 'package:monitor/view_models/network/network_transport.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkStatService {
  final dio = Dio();

  Future<DataState<List<NetworkModel>>> getNetworkStat() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final host = prefs.getString('host');
      final token = prefs.getString('token');

      final NetworkTransportService networkTransportService = NetworkTransportService();
      final NetworkReceiveService networkReceiveService = NetworkReceiveService();

      final transport = await networkTransportService.getTransport();
      if (transport is DataError) {
        throw DataError('Failed to retrieve transport data: ${transport.error}');
      }

      final receive = await networkReceiveService.getReceive();
      if (receive is DataError) {
        throw DataError('Failed to retrieve receive data: ${receive.error}');
      }

      final response = await dio.post(
          '$host/api_jsonrpc.php',
          data: {
            "jsonrpc": "2.0",
            "method": "history.get",
            "params": {
              "output": "extend",
              "history": 3,
              "itemids": [transport.data, receive.data],
              "time_from": 1731283284,
              "time_till": 1731337520,
              "sortfield": "clock",
              "sortorder": "ASC"
            },
            "auth": token,
            "id": 2
          }
      );
      return DataSuccess(response.data['result']
          .map<NetworkModel>((item) => NetworkModel.fromJson(item)).toList());
    } catch (e) {
      return DataError('An error occurred while fetching network stats: $e');
    }
  }
}
