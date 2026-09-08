import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/BottomSheet_Widget.dart';
import 'package:expense_manager/core/widgets/InputField.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:flutter/material.dart';

class AddTxn extends StatefulWidget {
  final bool? isincome;
  AddTxn({super.key, required this.isincome});

  @override
  State<AddTxn> createState() => _AddTxnState();
}

class _AddTxnState extends State<AddTxn> {
  bool? isincome;

  TextEditingController date = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController subcategory = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isincome = widget.isincome;
  }


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 24, color: AppColors.textPrimary),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: "Add New Transaction",
              size: TextSizes.Title_1,
              weight: TextWidget.Bold_text,
              color: AppColors.textPrimary,
            ),
            TextWidget(
              text: "Add your income of expense",
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
                        onTap: () {},
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
                          onPressed: () {},
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
                              setState(() {
                                if (isincome!) return;
                                isincome = !isincome!;
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
                        onTap: () {
                            showModalBottomSheet(context: context, builder: (context) {
                                    // return BottomSheetWidget();
                            },);
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      TextWidget(
                        text: "Sub-Category",
                        size: TextSizes.Title_3,
                        weight: TextWidget.Medium_text,
                      ),
                      SizedBox(height: height * 0.01),

                      Inputfield(
                        type: TextInputType.none,
                        hinttext: "Sub-Category",
                        controller: subcategory,
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextWidget(
                    text: "Save Transaction",
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
    subcategory.dispose();
    note.dispose();
  }
}
