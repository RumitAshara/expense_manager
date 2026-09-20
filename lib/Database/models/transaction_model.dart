class TransactionModel {
  final int? id;

  final double amount;

  /// income / expense
  final String type;

  final int categoryId;
  final int paymentTypeId;

  final String transactionDate;
  final String? note;

  final String createdAt;
  final String updatedAt;

  TransactionModel({
    this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.paymentTypeId,
    required this.transactionDate,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Model → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'category_id': categoryId,
      'payment_type_id': paymentTypeId,
      'transaction_date': transactionDate,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Map → Model
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      type: map['type'],
      categoryId: map['category_id'],
      paymentTypeId: map['payment_type_id'],
      transactionDate: map['transaction_date'],
      note: map['note'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  TransactionModel copyWith({
    int? id,
    double? amount,
    String? type,
    int? categoryId,
    int? paymentTypeId,
    String? transactionDate,
    String? note,
    String? createdAt,
    String? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      paymentTypeId: paymentTypeId ?? this.paymentTypeId,
      transactionDate: transactionDate ?? this.transactionDate,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}