import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  static const String _databaseName = 'expensio.db';
  static const int _databaseVersion = 1;

  // Table Names
  static const String categoriesTable = 'categories';
  static const String paymentTypesTable = 'payment_types';
  static const String transactionsTable = 'transactions';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      _databaseName,
    );

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      // onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  /// Enable Foreign Keys
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Create Database Tables
  Future<void> _onCreate(Database db, int version) async {
    // =========================
    // Categories Table
    // =========================

    await db.execute('''
      CREATE TABLE $categoriesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL CHECK(type IN ('income', 'expense')),
        icon TEXT,
        color TEXT,
        is_default INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // =========================
    // Payment Types Table
    // =========================

    await db.execute('''
      CREATE TABLE $paymentTypesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon TEXT,
        transaction_type TEXT NOT NULL
          CHECK(transaction_type IN ('income', 'expense', 'both')),
        is_default INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // =========================
    // Transactions Table
    // =========================

    await db.execute('''
      CREATE TABLE $transactionsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL CHECK(amount > 0),

        type TEXT NOT NULL
          CHECK(type IN ('income', 'expense')),

        category_id INTEGER NOT NULL,
        payment_type_id INTEGER NOT NULL,

        transaction_date TEXT NOT NULL,
        note TEXT,

        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,

        FOREIGN KEY (category_id)
          REFERENCES $categoriesTable(id)
          ON DELETE RESTRICT,

        FOREIGN KEY (payment_type_id)
          REFERENCES $paymentTypesTable(id)
          ON DELETE RESTRICT
      )
    ''');

    await _insertDefaultCategories(db);
    await _insertDefaultPaymentTypes(db);
  }

  Future<void> _insertDefaultPaymentTypes(Database db) async {
    final now = DateTime.now().toIso8601String();

    final defaultPaymentTypes = [
      {
        'name': 'Cash',
        'icon': 'payments',
        'transaction_type': 'both',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Digital Payment',
        'icon': 'phone_android',
        'transaction_type': 'both',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Bank Transfer',
        'icon': 'account_balance',
        'transaction_type': 'both',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Debit Card',
        'icon': 'credit_card',
        'transaction_type': 'expense',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Credit Card',
        'icon': 'credit_card',
        'transaction_type': 'expense',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Gift Card / Voucher',
        'icon': 'card_giftcard',
        'transaction_type': 'expense',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Other',
        'icon': 'more_horiz',
        'transaction_type': 'both',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
    ];

    final batch = db.batch();

    for (final paymentType in defaultPaymentTypes) {
      batch.insert(
        paymentTypesTable,
        paymentType,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> _insertDefaultCategories(Database db) async {
    final now = DateTime.now().toIso8601String();

    final defaultCategories = [
      // ==========================================
      // EXPENSE CATEGORIES
      // ==========================================

      {
        'name': 'Food & Dining',
        'type': 'expense',
        'icon': 'restaurant',
        'color': '#FF5722',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Transportation',
        'type': 'expense',
        'icon': 'directions_car',
        'color': '#2196F3',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Shopping',
        'type': 'expense',
        'icon': 'shopping_bag',
        'color': '#9C27B0',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Rent & Housing',
        'type': 'expense',
        'icon': 'home',
        'color': '#795548',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Bills & Utilities',
        'type': 'expense',
        'icon': 'receipt_long',
        'color': '#F44336',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Health & Medical',
        'type': 'expense',
        'icon': 'medical_services',
        'color': '#E91E63',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Entertainment',
        'type': 'expense',
        'icon': 'movie',
        'color': '#FF9800',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Education',
        'type': 'expense',
        'icon': 'school',
        'color': '#3F51B5',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Travel',
        'type': 'expense',
        'icon': 'flight',
        'color': '#00BCD4',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Personal Care',
        'type': 'expense',
        'icon': 'spa',
        'color': '#9C27B0',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Subscriptions',
        'type': 'expense',
        'icon': 'subscriptions',
        'color': '#673AB7',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Other Expense',
        'type': 'expense',
        'icon': 'more_horiz',
        'color': '#607D8B',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },

      // ==========================================
      // INCOME CATEGORIES
      // ==========================================

      {
        'name': 'Salary',
        'type': 'income',
        'icon': 'payments',
        'color': '#4CAF50',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Freelancing',
        'type': 'income',
        'icon': 'laptop_mac',
        'color': '#2196F3',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Business',
        'type': 'income',
        'icon': 'business',
        'color': '#009688',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Investments',
        'type': 'income',
        'icon': 'trending_up',
        'color': '#8BC34A',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Gifts',
        'type': 'income',
        'icon': 'card_giftcard',
        'color': '#E91E63',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Refund',
        'type': 'income',
        'icon': 'undo',
        'color': '#FF9800',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Rental Income',
        'type': 'income',
        'icon': 'home_work',
        'color': '#795548',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Interest',
        'type': 'income',
        'icon': 'account_balance',
        'color': '#00BCD4',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'Other Income',
        'type': 'income',
        'icon': 'more_horiz',
        'color': '#607D8B',
        'is_default': 1,
        'created_at': now,
        'updated_at': now,
      },
    ];

    final batch = db.batch();

    for (final category in defaultCategories) {
      batch.insert(
        categoriesTable,
        category,
      );
    }

    await batch.commit(noResult: true);
  }
  /// Close Database
  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}