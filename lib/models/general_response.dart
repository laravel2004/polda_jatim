class GeneralResponseModel {
  final String? itemId;
  final String? name;
  final String? key;

  const GeneralResponseModel({this.itemId, this.name, this.key});

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) {
    return GeneralResponseModel(
      itemId: json['itemid'],
      name: json['name'],
      key: json['key_'],
    );
  }

  factory GeneralResponseModel.fromEntity(GeneralResponseModel entity) {
    return GeneralResponseModel(
      itemId: entity.itemId,
      name: entity.name,
      key: entity.key,
    );
  }

  static List<GeneralResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GeneralResponseModel.fromJson(json)).toList();
  }
}
