import 'package:expense_manager/Database/controller/category_controller.dart';
import 'package:expense_manager/Database/controller/transaction_controller.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:expense_manager/screens/Transaction_Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Alldata extends StatefulWidget {
  const Alldata({super.key});

  @override
  State<Alldata> createState() => _AlldataState();
}

class _AlldataState extends State<Alldata> {
  final TransactionController transactionController =
  Get.find<TransactionController>();

  final CategoryController categoryController =
  Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.background,
        backgroundColor: AppColors.background,
        title: TextWidget(text: "View All", size: TextSizes.Heading_4, weight: TextWidget.Bold_text),
      ),
      body:  Expanded(
      child: Obx(() {
        final transactions =
        transactionController.transactions.toList();

        if (transactionController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        if (transactions.isEmpty) {
          return const Center(
            child: Text(
              'No transactions yet',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];

            final isIncome = transaction.type == 'income';

            final category = categoryController.categories
                .where(
                  (category) =>
              category.id == transaction.categoryId,
            )
                .firstOrNull;

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.005,
                horizontal: width*0.04,
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => TransactionDetails(transaction: transaction),));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.018,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: category?.name ?? 'Unknown',
                            size: TextSizes.Title_2,
                            weight: TextWidget.Medium_text,
                          ),

                          TextWidget(
                            text: category?.type.toUpperCase() ?? 'Unknown',
                            size: TextSizes.Title_2,
                            weight: TextWidget.Medium_text,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [

                          TextWidget(
                            text:
                            '${isIncome ? '+' : '-'}₹${transaction.amount.toStringAsFixed(2)}',
                            size: TextSizes.Title_2,
                            weight: TextWidget.Medium_text,
                            color: isIncome
                                ? AppColors.income
                                : AppColors.expense,
                          ),

                          TextWidget(
                            text: DateFormat('dd MMM yyyy').format(
                              DateTime.parse(transaction.transactionDate),
                            ),
                            size: TextSizes.Title_2,
                            weight: TextWidget.Medium_text,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    ),);
  }
}
