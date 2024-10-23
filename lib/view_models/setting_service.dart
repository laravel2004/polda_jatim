import 'package:dio/dio.dart';
import 'package:monitor/utils/data_state.dart';

class SettingService {
  final dio = Dio();

  Future<DataState<String>> saveSetting(String host, String token, String serverId) async {
    try {
      await dio.post('http://localhost:3000/setting', data: {
        'host': host,
        'token': token,
        'serverId': serverId,
      });
      return const DataSuccess('Setting saved');
    } catch (e) {
      return DataError(e.toString());
    }
  }
}