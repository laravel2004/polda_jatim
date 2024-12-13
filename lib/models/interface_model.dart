class InterfaceModel {
  final String ip;
  final String port;
  final String available;
  final String error;

  InterfaceModel({
    required this.ip,
    required this.port,
    required this.available,
    required this.error,
  });

  factory InterfaceModel.fromJson(Map<String, dynamic> json) {
    return InterfaceModel(
      ip: json['ip'] ?? '',
      port: json['port'] ?? '',
      available: json['available'] ?? '',
      error: json['error'] ?? '',
    );
  }

  static List<InterfaceModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => InterfaceModel.fromJson(json)).toList();
  }
}