import 'package:expense_manager/Database/controller/transaction_controller.dart';
import 'package:expense_manager/Database/repository/category_repository.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class CategoryController extends GetxController {
  final CategoryRepository _repository = CategoryRepository();

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  final RxBool isLoading = false.obs;

  @override 
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  /// ============================
  /// GET ALL CATEGORIES
  /// ============================

  Future<void> getAllCategories() async {
    try {
      isLoading.value = true;

      final data = await _repository.getAllCategories();

      categories.assignAll(data);
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to load categories',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
              color: AppColors.background,
            ),
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// ============================
  /// GET CATEGORIES BY TYPE
  /// ============================
  Future<List<CategoryModel>> getCategoriesByType(String type) async {
    try {
      return await _repository.getCategoriesByType(type);
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to load categories',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
              color: AppColors.background,
            ),
          ),
        );
      }
      return [];
    }
  }
  // Future<List<CategoryModel>> getCategoriesByType(
  //     String type,
  //     ) async {
  //   try {
  //     return await _repository.getCategoriesByType(type);
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to load categories',
  //     );
  //
  //     return [];
  //   }
  // }

  /// ============================
  /// ADD CATEGORY
  /// ============================

  Future<bool> addCategory(CategoryModel category) async {
    try {
      final result = await _repository.addCategory(category);

      if (result > 0) {
        await getAllCategories();
        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to add category',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
              color: AppColors.background,

            ),
          ),
        );
      }

      return false;
    }
  }

  /// ============================
  /// UPDATE CATEGORY
  /// ============================

  Future<bool> updateCategory(CategoryModel category) async {
    try {
      if (category.isDefault) {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: TextWidget(
                text: 'Default categories cannot be modified',
                size: TextSizes.Title_3,
                weight: TextWidget.Medium_text,
                color: AppColors.background,

              ),
            ),
          );
        }

        return false;
      }

      final result = await _repository.updateCategory(category);

      if (result > 0) {
        await getAllCategories();
        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to update category',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
              color: AppColors.background,

            ),
          ),
        );
      }

      return false;
    }
  }

  /// ============================
  /// DELETE CATEGORY
  /// ============================

  Future<bool> deleteCategory(CategoryModel category) async {
    try {
      if (category.id == null) {
        return false;
      }

      if (category.isDefault) {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: TextWidget(
                text: 'Default categories cannot be deleted',
                size: TextSizes.Title_3,
                weight: TextWidget.Medium_text,
                color: AppColors.background,

              ),
            ),
          );
        }

        return false;
      }

      final result = await _repository.deleteCategory(category.id!);

      if (result > 0) {
        await getAllCategories();
        
        // Refresh transactions list on the dashboard as transactions have been deleted
        if (Get.isRegistered<TransactionController>()) {
          await Get.find<TransactionController>().getAllTransactions();
        }

        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to delete category',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
              color: AppColors.background,

            ),
          ),
        );
      }

      return false;
    }
  }
}