class RecentSearchModel {
  final String id;
  final String query;
  final DateTime timestamp;

  RecentSearchModel({
    required this.id,
    required this.query,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'query': query,
        'timestamp': timestamp.toIso8601String(),
      };

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) => RecentSearchModel(
        id: json['id'],
        query: json['query'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

