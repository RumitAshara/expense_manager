import 'package:flutter/material.dart';

class IncomeCategoryIcons {
  IncomeCategoryIcons._();

  // Salary & Employment
  static const String salary = 'payments';
  static const String job = 'work';
  static const String bonus = 'money';
  static const String overtime = 'schedule';

  // Business & Freelance
  static const String business = 'business_center';
  static const String freelance = 'laptop_mac';
  static const String consulting = 'support_agent';
  static const String commission = 'commission';


  // Investments
  static const String investment = 'trending_up';
  static const String stocks = 'show_chart';
  static const String mutualFund = 'pie_chart';
  static const String dividend = 'account_balance';
  static const String interest = 'interest';

  // Rental & Property
  static const String rent = 'home';
  static const String property = 'apartment';

  // Gifts & Personal
  static const String gift = 'card_giftcard';
  static const String cashGift = 'redeem';

  // Refunds & Returns
  static const String refund = 'currency_exchange';
  static const String cashback = 'local_atm';

  // Other
  static const String lottery = 'confirmation_number';
  static const String pension = 'elderly';
  static const String other = 'category';

  /// All available income icons
  static const Map<String, IconData> all = {
    salary: Icons.payments,
    job: Icons.work,
    bonus: Icons.money,
    overtime: Icons.schedule,

    business: Icons.business_center,
    freelance: Icons.laptop_mac,
    consulting: Icons.support_agent,
    commission: Icons.percent,

    investment: Icons.trending_up,
    stocks: Icons.show_chart,
    mutualFund: Icons.pie_chart,
    dividend: Icons.account_balance,
    interest: Icons.percent,

    rent: Icons.home,
    property: Icons.apartment,

    gift: Icons.card_giftcard,
    cashGift: Icons.redeem,

    refund: Icons.currency_exchange,
    cashback: Icons.local_atm,

    lottery: Icons.confirmation_number,
    pension: Icons.elderly,
    other: Icons.category,
  };

  /// Get IconData from stored icon name
  static IconData getIcon(String iconName) {
    return all[iconName] ?? Icons.category;
  }
}
