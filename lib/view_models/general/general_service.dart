import 'package:dio/dio.dart';
import 'package:monitor/models/general_model.dart';
import 'package:monitor/utils/data_state.dart';
import 'package:monitor/view_models/network/network_receive.dart';
import 'package:monitor/view_models/network/network_transport.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralService {
  final dio = Dio();

  Future<DataState<List<GeneralModel>>> getNetworkStat(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final host = prefs.getString('host');
      final token = prefs.getString('token');
      final serverId = prefs.getString('serverId');

      final response = await dio.post(
          '$host/api_jsonrpc.php',
          data: {
            "jsonrpc": "2.0",
            "method": "graph.get",
            "params": {
              "output": ['graphid', 'name'],
              "hostids": serverId,
              "search": {
                "name": key
              },
              "sortfield": "name",
            },
            "auth": token,
            "id": 2
          }
      );

      print(response.data);
      return DataSuccess(response.data['result']
          .map<GeneralModel>((item) => GeneralModel.fromJson(item)).toList());
    } catch (e) {
      throw DataError('An error occurred while fetching network stats: $e');
    }
  }
}
