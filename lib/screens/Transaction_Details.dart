import 'package:expense_manager/Database/controller/category_controller.dart';
import 'package:expense_manager/Database/controller/payment_type_controller.dart';
import 'package:expense_manager/Database/controller/transaction_controller.dart';
import 'package:expense_manager/Database/models/transaction_model.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/helpers/category_helper.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:expense_manager/screens/Add_Txn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionDetails({super.key, required this.transaction,});
  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final categoryController = Get.find<CategoryController>();
    final paymentTypeController = Get.find<PaymentTypeController>();

    final currentTxn = transactionController.transactions.where((item) => item.id == transaction.id).firstOrNull ?? transaction;
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Transaction Details",size: TextSizes.Title_1,weight: TextWidget.Bold_text,),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async{
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTxn(
                      isincome: currentTxn.type == 'income',
                      transaction: currentTxn,
                    ),
                  ),
                );
              }

              if (value == 'delete') {
                final success = await transactionController.deleteTransaction(currentTxn.id!);
                if (success) {
                  Navigator.pop(context); // Navigates back to Dashboard
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: TextWidget(
                        text: "Transaction deleted successfully",
                        size: TextSizes.Title_3,
                        weight: TextWidget.Medium_text,
                        color: AppColors.background,
                      ),
                    ),
                  );
                }
              }
            },

            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined),
                    SizedBox(width: 12),
                    Text("Edit"),
                  ],
                ),
              ),

              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 12),
                    Text("Delete"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx((){
        final currentTxn = transactionController.transactions.firstWhere((item) => item.id == transaction.id, orElse: () => transaction);
        final matchedCategory = categoryController.categories.firstWhereOrNull((item) => item.id == currentTxn.categoryId);
        final matchedPaymentType = paymentTypeController.paymentTypes.where((item) => item.id == currentTxn.paymentTypeId).firstOrNull;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              spacing: height * 0.01,
              crossAxisAlignment: .start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(
                            CategoryHelper.getIcon(matchedCategory?.icon),
                            color: CategoryHelper.getColor(matchedCategory?.color),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    title: TextWidget(
                      text: "₹${currentTxn.amount.toStringAsFixed(2)}",
                      // text: service.serviceName,
                      size: TextSizes.Heading_4,
                      weight: TextWidget.Bold_text,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: .start,
                      children: [
                        SizedBox(height: height * 0.01),
                        TextWidget(
                          text: matchedCategory?.name ?? "Unknown",
                          size: TextSizes.Title_2,
                          weight: TextWidget.Medium_text,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      style: IconButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        backgroundColor: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_note,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: TextWidget(
                          text: "Amount",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                        ),
                        subtitle: TextWidget(
                          text: "₹${currentTxn.amount.toStringAsFixed(2)}",
                          // text: data.username,
                          size: TextSizes.Title_2,
                          weight: TextWidget.Bold_text,
                        ),
                        trailing: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () async{
                            await Clipboard.setData(
                              ClipboardData(text: "₹${currentTxn.amount.toStringAsFixed(2)}"),
                              // ClipboardData(text: data.username),
                            );
                          },
                          icon: Icon(
                            Icons.copy,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.label_important,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: TextWidget(
                          text: "Category",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                        ),
                        subtitle: TextWidget(
                          text: matchedCategory?.name ?? "Unknown",
                          // text: entrydata.categoryName,
                          size: TextSizes.Title_1,
                          weight: TextWidget.Bold_text,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.label_important,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: TextWidget(
                          text: "Payment Type",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                        ),
                        subtitle: TextWidget(
                          text: matchedPaymentType?.name ?? "Unknown",
                          // text: entrydata.categoryName,
                          size: TextSizes.Title_1,
                          weight: TextWidget.Bold_text,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.label_important,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: TextWidget(
                          text: "Income / Expense",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                        ),
                        subtitle: TextWidget(
                          text: currentTxn.type,
                          size: TextSizes.Title_1,
                          weight: TextWidget.Bold_text,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.event_note_sharp,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: TextWidget(
                          text: "Notes",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                        ),
                        subtitle: TextWidget(
                          text: currentTxn.note ?? "No Notes",
                          size: TextSizes.Title_2,
                          weight: TextWidget.Bold_text,
                          maxline: 10,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.date_range,
                            color: AppColors.primary,

                            size: 20,
                          ),
                        ),
                        title: TextWidget(
                          text: "Added On",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                        ),
                        subtitle: TextWidget(
                          text: DateFormat('dd MMM yyyy, hh:mm a').format(
                            DateTime.parse(currentTxn.createdAt),
                          ),
                          size: TextSizes.Title_2,
                          weight: TextWidget.Bold_text,
                          maxline: 10,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit_calendar,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: TextWidget(
                          text: "Last Modified",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                        ),
                        subtitle: TextWidget(
                          text: DateFormat('dd MMM yyyy, hh:mm a').format(
                            DateTime.parse(currentTxn.updatedAt),
                          ),
                          size: TextSizes.Title_2,
                          weight: TextWidget.Bold_text,
                          maxline: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  spacing: width * 0.04,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final success = await transactionController.deleteTransaction(currentTxn.id!);
                          if (success) {
                            Navigator.pop(context); // Navigates back to Dashboard
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: TextWidget(
                                  text: "Transaction deleted successfully",
                                  size: TextSizes.Title_3,
                                  weight: TextWidget.Medium_text,
                                  color: AppColors.background,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          surfaceTintColor: AppColors.surface,
                          fixedSize: Size.fromHeight(height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: BorderSide(color: AppColors.error),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: .center,
                          spacing: width * 0.04,
                          children: [
                            Icon(Icons.delete, color: AppColors.error),
                            TextWidget(
                              text: "Delete Entry",
                              size: TextSizes.Title_3,
                              weight: TextWidget.Bold_text,
                              color: AppColors.error,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          fixedSize: Size.fromHeight(height * 0.06),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTxn(
                                isincome: currentTxn.type == 'income',
                                transaction: currentTxn,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: .center,
                          spacing: width * 0.04,
                          children: [
                            Icon(Icons.edit, color: AppColors.background),
                            TextWidget(
                              text: "Edit Entry",
                              size: TextSizes.Title_3,
                              weight: TextWidget.Bold_text,
                              color: AppColors.background,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
