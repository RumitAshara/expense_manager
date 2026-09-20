class PaymentTypeModel {
  final int? id;
  final String name;
  final String? icon;

  /// income / expense / both
  final String transactionType;
  final bool isDefault;
  final String createdAt;
  final String updatedAt;

  PaymentTypeModel({
    this.id,
    required this.name,
    this.icon,
    required this.transactionType,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Model → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'transaction_type': transactionType,
      'is_default': isDefault ? 1 : 0,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Map → Model
  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeModel(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      transactionType: map['transaction_type'],
      isDefault: map['is_default'] == 1,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  PaymentTypeModel copyWith({
    int? id,
    String? name,
    String? icon,
    String? transactionType,
    bool? isDefault,
    String? createdAt,
    String? updatedAt,
  }) {
    return PaymentTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      transactionType: transactionType ?? this.transactionType,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}