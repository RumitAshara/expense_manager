import 'package:expense_manager/Database/repository/payment_type_repository.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/payment_type_model.dart';

class PaymentTypeController extends GetxController {
  final PaymentTypeRepository _repository = PaymentTypeRepository();

  final RxList<PaymentTypeModel> paymentTypes =
      <PaymentTypeModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllPaymentTypes();
  }

  /// ============================
  /// GET ALL PAYMENT TYPES
  /// ============================

  Future<void> getAllPaymentTypes() async {
    try {
      isLoading.value = true;

      final data = await _repository.getAllPaymentTypes();

      paymentTypes.assignAll(data);
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to load payment types',
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

  /// ============================
  /// GET PAYMENT TYPES
  /// BY TRANSACTION TYPE
  /// ============================

  Future<List<PaymentTypeModel>>
  getPaymentTypesByTransactionType(
      String type,
      ) async {
    try {
      return await _repository
          .getPaymentTypesByTransactionType(type);
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to load payment types',
              size: TextSizes.Title_3,
              weight: TextWidget.Medium_text,
            ),
          ),
        );
      }

      return [];
    }
  }

  /// ============================
  /// ADD PAYMENT TYPE
  /// ============================

  Future<bool> addPaymentType(
      PaymentTypeModel paymentType,
      ) async {
    try {
      final result =
      await _repository.addPaymentType(paymentType);

      if (result > 0) {
        await getAllPaymentTypes();
        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to add payment type',
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
  /// UPDATE PAYMENT TYPE
  /// ============================

  Future<bool> updatePaymentType(
      PaymentTypeModel paymentType,
      ) async {
    try {
      if (paymentType.isDefault) {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: TextWidget(
                text: 'Default payment types cannot be modified',
                size: TextSizes.Title_3,
                weight: TextWidget.Medium_text,
              ),
            ),
          );
        }

        return false;
      }

      final result =
      await _repository.updatePaymentType(paymentType);

      if (result > 0) {
        await getAllPaymentTypes();
        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to update payment type',
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
  /// DELETE PAYMENT TYPE
  /// ============================

  Future<bool> deletePaymentType(
      PaymentTypeModel paymentType,
      ) async {
    try {
      if (paymentType.id == null) {
        return false;
      }

      if (paymentType.isDefault) {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: TextWidget(
                text: 'Default payment types cannot be deleted',
                size: TextSizes.Title_3,
                weight: TextWidget.Medium_text,
              ),
            ),
          );
        }

        return false;
      }

      final result =
      await _repository.deletePaymentType(paymentType.id!);

      if (result > 0) {
        await getAllPaymentTypes();
        return true;
      }

      return false;
    } catch (e) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: 'Failed to delete payment type',
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