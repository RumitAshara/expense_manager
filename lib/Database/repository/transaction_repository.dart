import 'package:expense_manager/Database/Database_Helper.dart';
import 'package:expense_manager/Database/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// ============================
  /// CREATE TRANSACTION
  /// ============================

  Future<int> addTransaction(
      TransactionModel transaction,
      ) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      DatabaseHelper.transactionsTable,
      transaction.toMap(),
    );
  }

  /// ============================
  /// GET ALL TRANSACTIONS
  /// ============================

  Future<List<TransactionModel>> getAllTransactions() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.transactionsTable,
      orderBy: 'transaction_date DESC',
    );

    return maps
        .map((map) => TransactionModel.fromMap(map))
        .toList();
  }

  /// ============================
  /// GET TRANSACTIONS BY TYPE
  /// ============================

  Future<List<TransactionModel>> getTransactionsByType(
      String type,
      ) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.transactionsTable,
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'transaction_date DESC',
    );

    return maps
        .map((map) => TransactionModel.fromMap(map))
        .toList();
  }

  /// ============================
  /// GET SINGLE TRANSACTION
  /// ============================

  Future<TransactionModel?> getTransactionById(
      int id,
      ) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.transactionsTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return TransactionModel.fromMap(maps.first);
  }

  /// ============================
  /// UPDATE TRANSACTION
  /// ============================

  Future<int> updateTransaction(
      TransactionModel transaction,
      ) async {
    if (transaction.id == null) {
      throw Exception(
        'Transaction ID cannot be null while updating.',
      );
    }

    final Database db = await _databaseHelper.database;

    final updatedTransaction = transaction.copyWith(
      updatedAt: DateTime.now().toIso8601String(),
    );

    return await db.update(
      DatabaseHelper.transactionsTable,
      updatedTransaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  /// ============================
  /// DELETE TRANSACTION
  /// ============================

  Future<int> deleteTransaction(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      DatabaseHelper.transactionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}