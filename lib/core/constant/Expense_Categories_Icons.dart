import 'package:flutter/material.dart';

class ExpenseCategoryIcons {
  ExpenseCategoryIcons._();

  // Food
  static const String food = 'food';
  static const String groceries = 'groceries';
  static const String coffee = 'coffee';

  // Transport
  static const String transport = 'transport';
  static const String fuel = 'fuel';
  static const String bike = 'bike';
  static const String bus = 'bus';

  // Shopping
  static const String shopping = 'shopping';
  static const String clothes = 'clothes';
  static const String electronics = 'electronics';

  // Bills & Utilities
  static const String bills = 'bills';
  static const String electricity = 'electricity';
  static const String internet = 'internet';

  // Home
  static const String home = 'home';
  static const String rent = 'rent';

  // Health
  static const String health = 'health';
  static const String medicine = 'medicine';
  static const String fitness = 'fitness';

  // Entertainment
  static const String entertainment = 'entertainment';
  static const String games = 'games';
  static const String music = 'music';

  // Education
  static const String education = 'education';
  static const String books = 'books';

  // Finance
  static const String investment = 'investment';
  static const String savings = 'savings';
  static const String wallet = 'wallet';

  // Travel
  static const String travel = 'travel';
  static const String hotel = 'hotel';

  // Personal
  static const String gifts = 'gifts';
  static const String donation = 'donation';

  // Other
  static const String other = 'other';

  /// All available expense icons
  static const Map<String, IconData> all = {
    food: Icons.restaurant,
    groceries: Icons.shopping_cart,
    coffee: Icons.local_cafe,

    transport: Icons.directions_car,
    fuel: Icons.local_gas_station,
    bike: Icons.two_wheeler,
    bus: Icons.directions_bus,

    shopping: Icons.shopping_bag,
    clothes: Icons.checkroom,
    electronics: Icons.devices,

    bills: Icons.receipt_long,
    electricity: Icons.electric_bolt,
    internet: Icons.wifi,

    home: Icons.home,
    rent: Icons.apartment,

    health: Icons.health_and_safety,
    medicine: Icons.medication,
    fitness: Icons.fitness_center,

    entertainment: Icons.movie,
    games: Icons.sports_esports,
    music: Icons.music_note,

    education: Icons.school,
    books: Icons.menu_book,

    investment: Icons.trending_up,
    savings: Icons.savings,
    wallet: Icons.account_balance_wallet,

    travel: Icons.luggage,
    hotel: Icons.hotel,

    gifts: Icons.card_giftcard,
    donation: Icons.volunteer_activism,

    other: Icons.category,
  };

  /// Get IconData from stored icon name
  static IconData getIcon(String iconName) {
    return all[iconName] ?? Icons.category;
  }
}
