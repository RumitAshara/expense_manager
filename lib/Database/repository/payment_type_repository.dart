import 'package:expense_manager/Database/Database_Helper.dart';
import 'package:expense_manager/Database/models/payment_type_model.dart';
import 'package:sqflite/sqflite.dart';

class PaymentTypeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// ============================
  /// CREATE PAYMENT TYPE
  /// ============================

  Future<int> addPaymentType(PaymentTypeModel paymentType) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      DatabaseHelper.paymentTypesTable,
      paymentType.toMap(),
    );
  }

  /// ============================
  /// GET ALL PAYMENT TYPES
  /// ============================

  Future<List<PaymentTypeModel>> getAllPaymentTypes() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.paymentTypesTable,
      orderBy: 'name ASC',
    );

    return maps
        .map((map) => PaymentTypeModel.fromMap(map))
        .toList();
  }

  /// ============================
  /// GET PAYMENT TYPES BY TRANSACTION TYPE
  ///
  /// Income → income + both
  /// Expense → expense + both
  /// ============================

  Future<List<PaymentTypeModel>> getPaymentTypesByTransactionType(
      String transactionType,
      ) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.paymentTypesTable,
      where: '''
        transaction_type = ?
        OR transaction_type = ?
      ''',
      whereArgs: [
        transactionType,
        'both',
      ],
      orderBy: 'name ASC',
    );

    return maps
        .map((map) => PaymentTypeModel.fromMap(map))
        .toList();
  }

  /// ============================
  /// UPDATE PAYMENT TYPE
  /// Only custom payment types can be updated
  /// ============================

  Future<int> updatePaymentType(
      PaymentTypeModel paymentType,
      ) async {
    if (paymentType.id == null) {
      throw Exception(
        'Payment Type ID cannot be null while updating.',
      );
    }

    final Database db = await _databaseHelper.database;

    final updatedPaymentType = paymentType.copyWith(
      updatedAt: DateTime.now().toIso8601String(),
    );

    return await db.update(
      DatabaseHelper.paymentTypesTable,
      updatedPaymentType.toMap(),
      where: 'id = ? AND is_default = 0',
      whereArgs: [paymentType.id],
    );
  }

  /// ============================
  /// DELETE PAYMENT TYPE
  /// Only custom payment types can be deleted
  /// ============================

  Future<int> deletePaymentType(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      DatabaseHelper.paymentTypesTable,
      where: 'id = ? AND is_default = 0',
      whereArgs: [id],
    );
  }
}