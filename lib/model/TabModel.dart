class TabModel {
  final String id;
  final String title;
  final String url;
  final String createdAt;
  final String updatedAt;

  TabModel({
    required this.id,
    required this.title,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TabModel.fromJson(Map<String, dynamic> json) {
    return TabModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

