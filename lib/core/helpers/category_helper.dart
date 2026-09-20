import 'package:flutter/material.dart';

class CategoryHelper {
  // =========================
  // ICON
  // =========================

  static IconData getIcon(String? iconName) {
    switch (iconName) {
    // Expense
      case 'restaurant':
        return Icons.restaurant;

      case 'directions_car':
        return Icons.directions_car;

      case 'shopping_bag':
        return Icons.shopping_bag;

      case 'home':
        return Icons.home;

      case 'receipt_long':
        return Icons.receipt_long;

      case 'medical_services':
        return Icons.medical_services;

      case 'movie':
        return Icons.movie;

      case 'school':
        return Icons.school;

      case 'flight':
        return Icons.flight;

      case 'spa':
        return Icons.spa;

      case 'subscriptions':
        return Icons.subscriptions;

    // Income
      case 'payments':
        return Icons.payments;

      case 'laptop_mac':
        return Icons.laptop_mac;

      case 'business':
        return Icons.business;

      case 'trending_up':
        return Icons.trending_up;

      case 'card_giftcard':
        return Icons.card_giftcard;

      case 'undo':
        return Icons.undo;

      case 'home_work':
        return Icons.home_work;

      case 'account_balance':
        return Icons.account_balance;

    // Common
      case 'more_horiz':
        return Icons.more_horiz;

      default:
        return Icons.category_outlined;
    }
  }

  static Color getColor(String? colorCode) {
    if (colorCode == null || colorCode.isEmpty) {
      return Colors.grey;
    }

    try {
      String hex = colorCode.replaceAll('#', '');

      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }
}