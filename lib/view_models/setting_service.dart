import 'package:monitor/utils/data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {

  Future<DataState<String>> saveSetting(String host, String token, String serverId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('host', host);
      await prefs.setString('token', token);
      await prefs.setString('serverId', serverId);
      return const DataSuccess('Setting saved');
    } catch (e) {
      return DataError(e.toString());
    }
  }
}