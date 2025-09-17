class SettingsModel {
  final String id;
  final String key;
  final String value;

  SettingsModel({
    required this.id,
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'value': value,
      };

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        id: json['id'],
        key: json['key'],
        value: json['value'],
      );
}

