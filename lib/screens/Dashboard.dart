import 'package:expense_manager/Database/controller/category_controller.dart';
import 'package:expense_manager/Database/controller/transaction_controller.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:expense_manager/screens/Add_Txn.dart';
import 'package:expense_manager/screens/AllData.dart';
import 'package:expense_manager/screens/Transaction_Details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        title: TextWidget(text: "Dashboard", size: TextSizes.Heading_4, weight: TextWidget.Bold_text),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: "Good Morning, User 👋",
                size: TextSizes.Title_2,
                weight: TextWidget.Bold_text,
              ),
              TextWidget(
                text: "Here is your financial over view",
                size: TextSizes.Title_3,
                weight: TextWidget.Bold_text,
              ),
              SizedBox(height: height * 0.01),
              Obx(() => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Column(
                    spacing: height*0.01,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Current Balance",
                        size: TextSizes.Title_1,
                        weight: TextWidget.Medium_text,
                        color: AppColors.white,
                      ),
                      TextWidget(
                        text: "₹${transactionController.totalBalance.value.toStringAsFixed(2)}",
                        size: TextSizes.Heading_4,
                        weight: TextWidget.Bold_text,
                        color: AppColors.white,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(width * 0.01),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.arrow_upward,
                                  size: 24,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Income",
                                    size: TextSizes.Title_2,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                  TextWidget(
                                    text: "₹${transactionController.totalIncome.value.toStringAsFixed(2)}",
                                    size: TextSizes.Title_2,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(width * 0.01),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: 24,
                                  color: AppColors.expense,
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Expense",
                                    size: TextSizes.Title_2,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                  TextWidget(
                                    text: "₹${transactionController.totalExpense.value.toStringAsFixed(2)}",
                                    size: TextSizes.Title_2,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Recent Transactions",
                    size: TextSizes.Title_1,
                    weight: TextWidget.Bold_text,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Alldata(),));
                    },
                    child: TextWidget(
                      text: "View All",
                      size: TextSizes.Title_2,
                      weight: TextWidget.Bold_text,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(() {
                  final transactions =
                  transactionController.transactions.take(10).toList();

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
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTxn(isincome: true),));
      },child: Icon(Icons.add,color: AppColors.background,),backgroundColor: AppColors.primary,),
    );
  }
}
