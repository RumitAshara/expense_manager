import 'package:expense_manager/Database/repository/transaction_repository.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/transaction_model.dart';

class TransactionController extends GetxController {
  final TransactionRepository _repository =
  TransactionRepository();

  final RxList<TransactionModel> transactions =
      <TransactionModel>[].obs;

  final RxDouble totalBalance = 0.0.obs;
  final RxDouble totalIncome = 0.0.obs;
  final RxDouble totalExpense = 0.0.obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllTransactions();
  }

  /// ============================
  /// GET ALL TRANSACTIONS
  /// ============================

  Future<void> getAllTransactions() async {
    try {
      isLoading.value = true;

      final data = await _repository.getAllTransactions();

      transactions.assignAll(data);
      _calculateTotals();
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to load transactions',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
            ),
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateTotals() {
    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    totalIncome.value = income;
    totalExpense.value = expense;
    totalBalance.value = income - expense;
  }

  /// ============================
  /// ADD TRANSACTION
  /// ============================

  Future<bool> addTransaction(TransactionModel transaction,) async {
    try {
      final result =
      await _repository.addTransaction(transaction);

      print("INSERT RESULT: $result");

      if (result > 0) {
        await getAllTransactions();
        return true;
      }

      return false;
    } catch (e, stackTrace) {
      print("ADD TRANSACTION ERROR: $e");
      print(stackTrace);

      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to add transaction: $e',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
            ),
          ),
        );
      }

      return false;
    }
  }

  /// ============================
  /// UPDATE TRANSACTION
  /// ============================

  Future<bool> updateTransaction(TransactionModel transaction,) async {
    try {
      final result =
      await _repository.updateTransaction(transaction);

      if (result > 0) {
        await getAllTransactions();
        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to update transaction',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
            ),
          ),
        );
      }

      return false;
    }
  }

  /// ============================
  /// DELETE TRANSACTION
  /// ============================

  Future<bool> deleteTransaction(int id) async {
    try {
      final result =
      await _repository.deleteTransaction(id);

      if (result > 0) {
        await getAllTransactions();
        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to delete transaction',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
            ),
          ),
        );
      }

      return false;
    }
  }
}