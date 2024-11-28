class NetworkModel {
  final String? itemId;
  final String? clock;
  final String? value;
  final String? ns;

  const NetworkModel({this.itemId, this.clock, this.value, this.ns});

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(
      itemId: json['itemid'],
      clock: json['clock'],
      value: json['value'],
      ns: json['ns'],
    );
  }

  factory NetworkModel.fromEntity(NetworkModel entity) {
    return NetworkModel(
      itemId: entity.itemId,
      clock: entity.clock,
      value: entity.value,
      ns: entity.ns,
    );
  }

  static List<NetworkModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NetworkModel.fromJson(json)).toList();
  }
}