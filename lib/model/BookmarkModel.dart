class BookmarkModel {
  final String id;
  final String title;
  final String url;
  final String? favicon;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookmarkModel({
    required this.id,
    required this.title,
    required this.url,
    this.favicon,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'url': url,
    'favicon': favicon,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  /// Create from JSON (database retrieval)
  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
    id: json['id'] as String,
    title: json['title'] as String,
    url: json['url'] as String,
    favicon: json['favicon'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  /// Create a copy with updated fields
  BookmarkModel copyWith({
    String? id,
    String? title,
    String? url,
    String? favicon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookmarkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      favicon: favicon ?? this.favicon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Update the bookmark with new timestamp
  BookmarkModel updated({
    String? title,
    String? url,
    String? favicon,
  }) {
    return copyWith(
      title: title,
      url: url,
      favicon: favicon,
      updatedAt: DateTime.now(),
    );
  }

  /// Factory constructor for creating new bookmark
  factory BookmarkModel.create({
    required String title,
    required String url,
    String? favicon,
    String? customId,
  }) {
    final now = DateTime.now();
    return BookmarkModel(
      id: customId ?? now.millisecondsSinceEpoch.toString(),
      title: title.trim(),
      url: url.trim(),
      favicon: favicon?.trim(),
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Check if this bookmark matches another by URL
  bool hasSameUrl(BookmarkModel other) {
    return url.toLowerCase() == other.url.toLowerCase();
  }

  /// Check if bookmark contains search query
  bool matchesSearch(String query) {
    if (query.trim().isEmpty) return true;

    final lowercaseQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowercaseQuery) ||
        url.toLowerCase().contains(lowercaseQuery);
  }

  /// Get formatted creation date
  String get formattedCreatedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }

  /// Get domain from URL
  String get domain {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (e) {
      return url;
    }
  }

  /// Validate if bookmark has required fields
  bool get isValid {
    return id.isNotEmpty &&
        title.trim().isNotEmpty &&
        url.trim().isNotEmpty &&
        _isValidUrl(url);
  }

  /// Check if URL is valid
  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookmarkModel &&
        other.id == id &&
        other.title == title &&
        other.url == url &&
        other.favicon == favicon &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      url,
      favicon,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'BookmarkModel(id: $id, title: $title, url: $url, favicon: $favicon, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}