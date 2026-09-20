import 'package:expense_manager/Database/controller/category_controller.dart';
import 'package:expense_manager/Database/controller/payment_type_controller.dart';
import 'package:expense_manager/Database/controller/transaction_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController(), permanent: true);

    Get.put(PaymentTypeController(), permanent: true);

    Get.put(TransactionController(), permanent: true);
  }
}