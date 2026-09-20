import 'package:flutter/material.dart';

class PaymentTypeHelper {
  static IconData getIcon(String? iconName) {
    switch (iconName) {
      case 'payments':
        return Icons.payments;
      case 'phone_android':
        return Icons.phone_android;
      case 'account_balance':
        return Icons.account_balance;
      case 'credit_card':
        return Icons.credit_card;
      case 'card_giftcard':
        return Icons.card_giftcard;
      case 'more_horiz':
        return Icons.more_horiz;
      default:
        return Icons.account_balance_wallet_outlined;
    }
  }
}