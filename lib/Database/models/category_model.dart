class CategoryModel {
  final int? id;
  final String name;
  final String type;
  final String? icon;
  final String? color;
  final bool isDefault;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    this.id,
    required this.name,
    required this.type,
    this.icon,
    this.color,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert Model → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'icon': icon,
      'color': color,
      'is_default': isDefault ? 1 : 0,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Convert Map → Model
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      icon: map['icon'],
      color: map['color'],
      isDefault: map['is_default'] == 1,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  /// Create a copy with updated values
  CategoryModel copyWith({
    int? id,
    String? name,
    String? type,
    String? icon,
    String? color,
    bool? isDefault,
    String? createdAt,
    String? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}