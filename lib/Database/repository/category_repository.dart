import 'package:expense_manager/Database/Database_Helper.dart';
import 'package:expense_manager/Database/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// ============================
  /// CREATE CATEGORY
  /// ============================

  Future<int> addCategory(CategoryModel category) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      DatabaseHelper.categoriesTable,
      category.toMap(),
    );
  }

  /// ============================
  /// GET ALL CATEGORIES
  /// ============================

  Future<List<CategoryModel>> getAllCategories() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.categoriesTable,
      orderBy: 'type ASC, name ASC',
    );

    return maps.map((map) {
      return CategoryModel.fromMap(map);
    }).toList();
  }

  /// ============================
  /// GET CATEGORIES BY TYPE
  /// ============================

  Future<List<CategoryModel>> getCategoriesByType(
      String type,
      ) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.categoriesTable,
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'name ASC',
    );

    return maps
        .map((map) => CategoryModel.fromMap(map))
        .toList();
  }

  /// ============================
  /// UPDATE CATEGORY
  /// Only custom categories can be updated
  /// ============================

  Future<int> updateCategory(CategoryModel category) async {
    if (category.id == null) {
      throw Exception('Category ID cannot be null while updating.');
    }

    final Database db = await _databaseHelper.database;

    final updatedCategory = category.copyWith(
      updatedAt: DateTime.now().toIso8601String(),
    );

    return await db.update(
      DatabaseHelper.categoriesTable,
      updatedCategory.toMap(),
      where: 'id = ? AND is_default = 0',
      whereArgs: [category.id],
    );
  }

  /// ============================
  /// DELETE CATEGORY
  /// Only custom categories can be deleted. Cascades to delete related transactions.
  /// ============================

  Future<int> deleteCategory(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.transaction((txn) async {
      // First delete all transactions matching the category_id
      await txn.delete(
        DatabaseHelper.transactionsTable,
        where: 'category_id = ?',
        whereArgs: [id],
      );

      // Then delete the category itself
      return await txn.delete(
        DatabaseHelper.categoriesTable,
        where: 'id = ? AND is_default = 0',
        whereArgs: [id],
      );
    });
  }
}