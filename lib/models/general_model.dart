class GeneralModel {
  final String graphId;
  final String name;

  const GeneralModel({required this.graphId, required this.name});

  factory GeneralModel.fromJson(Map<String, dynamic> json) {
    return GeneralModel(
      graphId: json['graphid'],
      name: json['name'],
    );
  }

  factory GeneralModel.fromEntity(GeneralModel entity) {
    return GeneralModel(
      graphId: entity.graphId,
      name: entity.name,
    );
  }

  static List<GeneralModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GeneralModel.fromJson(json)).toList();
  }
}