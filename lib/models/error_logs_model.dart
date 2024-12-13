class ErrorLogsModel {
  final String name;
  final String clock;
  final List<Map<String, String>> tags;

  ErrorLogsModel({
    required this.name,
    required this.clock,
    required this.tags,
  });

  factory ErrorLogsModel.fromJson(Map<String, dynamic> json) {
    // Validasi bahwa json['tags'] adalah List<dynamic>
    final tagsJson = json['tags'];

    List<Map<String, String>> parseTags() {
      if (tagsJson is List) {
        return tagsJson
            .map((tag) {
          // Validasi bahwa elemen `tag` adalah Map<String, dynamic>
          if (tag is Map<String, dynamic>) {
            return {
              'tag': tag['tag'] ?? '',
              'value': tag['value'] ?? '',
            };
          } else {
            // Abaikan elemen yang tidak sesuai format
            return null;
          }
        })
            .whereType<Map<String, String>>() // Hanya ambil elemen valid
            .toList();
      }
      return []; // Jika `tags` bukan List, kembalikan List kosong
    }

    return ErrorLogsModel(
      name: json['name'] ?? '',
      clock: json['clock'] ?? '',
      tags: parseTags(),
    );
  }

  factory ErrorLogsModel.fromEntity(ErrorLogsModel entity) {
    return ErrorLogsModel(
      name: entity.name,
      clock: entity.clock,
      tags: entity.tags,
    );
  }

  static List<ErrorLogsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ErrorLogsModel.fromJson(json)).toList();
  }
}
