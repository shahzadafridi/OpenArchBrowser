class WorkspaceModel {
  final String id;
  final String name;
  final List<String> tabUrls;

  WorkspaceModel({
    required this.id,
    required this.name,
    required this.tabUrls,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tabUrls': tabUrls.join(','),
      };

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) => WorkspaceModel(
        id: json['id'],
        name: json['name'],
        tabUrls: (json['tabUrls'] as String).split(','),
      );
}

