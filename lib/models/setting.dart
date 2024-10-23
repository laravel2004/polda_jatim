class SettingModel {
  final String? host;
  final String? token;
  final String? serverId;

  const SettingModel({this.host, this.token, this.serverId});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      host: json['host'],
      token: json['token'],
      serverId: json['serverId'],
    );
  }

  factory SettingModel.fromEntity(SettingModel entity) {
    return SettingModel(
      host: entity.host,
      token: entity.token,
      serverId: entity.serverId,
    );
  }

}