import 'package:expense_manager/Database/controller/category_controller.dart';
import 'package:expense_manager/Database/controller/payment_type_controller.dart';
import 'package:expense_manager/Database/controller/transaction_controller.dart';
import 'package:expense_manager/Database/models/category_model.dart';
import 'package:expense_manager/Database/models/payment_type_model.dart';
import 'package:expense_manager/Database/models/transaction_model.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/helpers/category_helper.dart';
import 'package:expense_manager/core/helpers/payment_helper.dart';
import 'package:expense_manager/core/widgets/BottomSheet_Widget.dart';
import 'package:expense_manager/core/widgets/InputField.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AddTxn extends StatefulWidget {
  final bool? isincome;
  final TransactionModel? transaction;
  AddTxn({super.key, required this.isincome,this.transaction});

  @override
  State<AddTxn> createState() => _AddTxnState();
}

class _AddTxnState extends State<AddTxn> {
  bool? isincome;
  final CategoryController categoryController =
  Get.find<CategoryController>();
  final PaymentTypeController paymentTypeController =
  Get.find<PaymentTypeController>();
  final TransactionController transactionController =
  Get.find<TransactionController>();

  PaymentTypeModel? selectedPaymentType;
  TextEditingController paymentType = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isincome = widget.isincome;
    if (widget.transaction != null) {
      final txn = widget.transaction!;
      isincome = txn.type == 'income';
      amount.text = txn.amount.toString();
      date.text = DateFormat('dd MMM yyyy').format(DateTime.parse(txn.transactionDate));
      note.text = txn.note ?? '';

      // Set selected objects
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectedCategory = categoryController.categories
            .firstWhereOrNull((c) => c.id == txn.categoryId);
        if (selectedCategory != null) {
          category.text = selectedCategory!.name;
        }

        selectedPaymentType = paymentTypeController.paymentTypes
            .firstWhereOrNull((p) => p.id == txn.paymentTypeId);
        if (selectedPaymentType != null) {
          paymentType.text = selectedPaymentType!.name;
        }
        setState(() {});
      });
    }
  }

  CategoryModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text:  widget.transaction == null
                  ? "Add New Transaction"
                  : "Edit Transaction",
              size: TextSizes.Title_1,
              weight: TextWidget.Bold_text,
              color: AppColors.textPrimary,
            ),
            TextWidget(
              text: widget.transaction == null
                  ? "Add your income of expense"
                  : "Update your transaction details",
              size: TextSizes.Title_3,
              weight: TextWidget.Bold_text,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.history, color: AppColors.primary, size: 24),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.border.withValues(alpha: 0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Date",
                        size: TextSizes.Title_3,
                        weight: TextWidget.Medium_text,
                      ),
                      SizedBox(height: height * 0.01),
                      Inputfield(
                        type: TextInputType.none,
                        hinttext: "Date",
                        controller: date,
                        prefixicon: Icon(
                          Icons.date_range,
                          size: 24,
                          color: AppColors.primary,
                        ),
                        readOnly: true,
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            date.text = DateFormat(
                              'dd MMM yyyy',
                            ).format(pickedDate);
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      TextWidget(
                        text: "Amount",
                        size: TextSizes.Title_3,
                        weight: TextWidget.Medium_text,
                      ),
                      SizedBox(height: height * 0.01),
                      Inputfield(
                        type: TextInputType.number,
                        hinttext: "Amount",
                        controller: amount,
                        prefixicon: Icon(
                          Icons.currency_rupee,
                          size: 24,
                          color: AppColors.primary,
                        ),
                        postfixicon: IconButton(
                          onPressed: () {
                            setState(() {
                              amount.text = '';
                            });
                          },
                          icon: CircleAvatar(
                            backgroundColor: AppColors.textSecondary.withValues(
                              alpha: 0.1,
                            ),
                            radius: 12,
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isincome!) return;
                              setState(() {
                                isincome = !isincome!;
                                selectedCategory = null;
                                category.text = '';
                                selectedPaymentType = null;
                                paymentType.text = '';
                              });
                            },
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.05,
                              padding: EdgeInsets.all(width * 0.01),
                              decoration: BoxDecoration(
                                color: isincome!
                                    ? AppColors.income.withValues(alpha: 0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isincome!
                                      ? AppColors.income
                                      : AppColors.textSecondary.withValues(
                                          alpha: 0.5,
                                        ),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    size: 20,
                                    color: AppColors.income,
                                  ),
                                  SizedBox(width: width * 0.02),
                                  TextWidget(
                                    text: "Income",
                                    size: TextSizes.Title_3,
                                    weight: TextWidget.Medium_text,
                                    color: isincome!
                                        ? AppColors.income
                                        : AppColors.textPrimary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!isincome!) return;
                              setState(() {
                                isincome = !isincome!;
                                selectedCategory = null;
                                category.text = '';
                                selectedPaymentType = null;
                                paymentType.text = '';
                              });
                            },
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.05,
                              padding: EdgeInsets.all(width * 0.01),
                              decoration: BoxDecoration(
                                color: isincome!
                                    ? AppColors.transparent
                                    : AppColors.expense.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isincome!
                                      ? AppColors.textSecondary.withValues(
                                          alpha: 0.5,
                                        )
                                      : AppColors.expense,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    size: 20,
                                    color: AppColors.expense,
                                  ),
                                  SizedBox(width: width * 0.02),
                                  TextWidget(
                                    text: "Expense",
                                    size: TextSizes.Title_3,
                                    weight: TextWidget.Medium_text,
                                    color: isincome!
                                        ? AppColors.textPrimary
                                        : AppColors.expense,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.border.withValues(alpha: 0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 0.1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Category",
                        size: TextSizes.Title_3,
                        weight: TextWidget.Medium_text,
                      ),
                      SizedBox(height: height * 0.01),

                      Inputfield(
                        type: TextInputType.none,
                        hinttext: "Category",
                        readOnly: true,
                        controller: category,
                        prefixicon: selectedCategory == null
                            ? Icon(
                          Icons.category_outlined,
                          size: 24,
                          color: AppColors.primary,
                        )
                            : Icon(
                          CategoryHelper.getIcon(selectedCategory!.icon),
                          size: 24,
                          color: CategoryHelper.getColor(selectedCategory!.color),
                        ),
                        onTap: ()async{
                          final String type =
                          isincome == true ? 'income' : 'expense';
                          await categoryController.getAllCategories();
                          showModalBottomSheet(
                            showDragHandle: true,
                            isDismissible: true,
                            backgroundColor: AppColors.surface,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                child: Obx(() {
                                  final categories = categoryController.categories
                                      .where((item) => item.type == type)
                                      .toList();

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: categories.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemBuilder: (context, index) {
                                      final item = categories[index];

                                      final categoryColor =
                                      CategoryHelper.getColor(item.color);

                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            selectedCategory = item;
                                            category.text = item.name;
                                          });

                                          Navigator.pop(context);
                                        },

                                        leading: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: categoryColor.withValues(alpha: 0.3),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            CategoryHelper.getIcon(item.icon),
                                            color: categoryColor,
                                          ),
                                        ),

                                        title: TextWidget(
                                          text: item.name,
                                          size: TextSizes.Title_2,
                                          weight: TextWidget.Medium_text,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              );
                            },
                          );
                        },

                      ),
                      SizedBox(height: height * 0.02),
                      TextWidget(
                        text: "Payment Type",
                        size: TextSizes.Title_3,
                        weight: TextWidget.Medium_text,
                      ),
                      SizedBox(height: height * 0.01),

                      Inputfield(
                        type: TextInputType.none,
                        hinttext: "Payment Type",
                        readOnly: true,
                        controller: paymentType,

                        prefixicon: selectedPaymentType == null
                            ? Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 24,
                          color: AppColors.primary,
                        )
                            : Icon(
                          PaymentTypeHelper.getIcon(selectedPaymentType!.icon),
                          size: 24,
                          color: AppColors.primary,
                        ),

                        onTap: () {
                          final String type =
                          isincome == true ? 'income' : 'expense';

                          showModalBottomSheet(
                            showDragHandle: true,
                            isDismissible: true,
                            backgroundColor: AppColors.surface,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                child: Obx(() {
                                  final paymentTypes =
                                  paymentTypeController.paymentTypes
                                      .where(
                                        (item) =>
                                    item.transactionType == type ||
                                        item.transactionType == 'both',
                                  )
                                      .toList();

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: paymentTypes.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemBuilder: (context, index) {
                                      final item = paymentTypes[index];

                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            selectedPaymentType = item;
                                            paymentType.text = item.name;
                                          });

                                          Navigator.pop(context);
                                        },

                                        leading: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            PaymentTypeHelper.getIcon(item.icon),
                                            color: AppColors.primary,
                                          ),
                                        ),

                                        title: TextWidget(
                                          text: item.name,
                                          size: TextSizes.Title_2,
                                          weight: TextWidget.Medium_text,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              );
                            },
                          );
                        },

                      ),
                      SizedBox(height: height * 0.02),
                      TextWidget(
                        text: "Note (Optional)",
                        size: TextSizes.Title_3,
                        weight: TextWidget.Medium_text,
                      ),
                      SizedBox(height: height * 0.01),

                      Inputfield(
                        type: TextInputType.multiline,
                        hinttext: "Note",
                        controller: note,
                        maxlines: 5,
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width,
                height: height * 0.05,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (amount.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: "Please enter amount",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                            color: AppColors.background,

                          ),
                        ),
                      );
                      return;
                    }

                    if (date.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: "Please select date",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                            color: AppColors.background,

                          ),
                        ),
                      );
                      return;
                    }

                    if (selectedCategory == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: "Please select category",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                            color: AppColors.background,

                          ),
                        ),
                      );
                      return;
                    }

                    if (selectedPaymentType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: "Please select payment type",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                            color: AppColors.background,
                          ),
                        ),
                      );
                      return;
                    }

                    try {
                      final now = DateTime.now().toIso8601String();

                      if (widget.transaction == null) {
                        final transaction = TransactionModel(
                          amount: double.parse(amount.text.trim()),
                          type: isincome == true ? 'income' : 'expense',
                          categoryId: selectedCategory!.id!,
                          paymentTypeId: selectedPaymentType!.id!,
                          transactionDate: DateFormat('dd MMM yyyy')
                              .parse(date.text)
                              .toIso8601String(),
                          note: note.text.trim().isEmpty ? null : note.text.trim(),
                          createdAt: now,
                          updatedAt: now,
                        );

                        await transactionController.addTransaction(transaction);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: TextWidget(
                              text: "Transaction added successfully",
                              size: TextSizes.Title_3,
                              weight: TextWidget.Medium_text,
                              color: AppColors.background,
                            ),
                          ),
                        );
                      } else {
                        final transaction = widget.transaction!.copyWith(
                          amount: double.parse(amount.text.trim()),
                          type: isincome == true ? 'income' : 'expense',
                          categoryId: selectedCategory!.id!,
                          paymentTypeId: selectedPaymentType!.id!,
                          transactionDate: DateFormat('dd MMM yyyy')
                              .parse(date.text)
                              .toIso8601String(),
                          note: note.text.trim().isEmpty ? null : note.text.trim(),
                          updatedAt: now,
                        );

                        await transactionController.updateTransaction(transaction);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: TextWidget(
                              text: "Transaction updated successfully",
                              size: TextSizes.Title_3,
                              weight: TextWidget.Medium_text,
                              color: AppColors.background,
                            ),
                          ),
                        );
                      }
                      date.clear();
                      category.clear();
                      amount.clear();
                      paymentType.clear();
                      note.clear();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }

                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: widget.transaction == null
                                ? "Failed to add transaction"
                                : "Failed to update transaction",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                            color: AppColors.background,

                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextWidget(
                    text: widget.transaction == null
                        ? "Save Transaction"
                        : "Update Transaction",
                    size: TextSizes.Title_3,
                    weight: TextWidget.Medium_text,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width,
                height: height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        width: 1,
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  child: TextWidget(
                    text: "Cancel",
                    size: TextSizes.Title_3,
                    weight: TextWidget.Medium_text,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    date.dispose();
    category.dispose();
    amount.dispose();
    paymentType.dispose();
    note.dispose();
  }
}
