import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:expense_manager/screens/Add_Txn.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  List<Map> li = [
    {
      "title": "Lunch",
      "sub": "Foods & Drinks",
      "amount": "-320.00",
      "date": "Today",
      "isincome":false,
    },
    {
      "title": "Shopping",
      "sub": "Shopping",
      "amount": "-1250",
      "date": "Today",
      "isincome":false,
    },
    {
      "title": "Bus Ticket",
      "sub": "Transport",
      "amount": "-80.00",
      "date": "yesterday",
      "isincome":false,
    },
    {
      "title": "Salary",
      "sub": "Salary",
      "amount": "30,000.00",
      "date": "22 may 2026",
      "isincome":true
    },
  ];
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 24)),
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, size: 24),
          ),
          SizedBox(width: width * 0.04),
          CircleAvatar(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, size: 24, color: AppColors.primary),
            ),
            backgroundColor: AppColors.primaryLight,
          ),
        ],
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
                text: "Good Morning, Rumit 👋",
                size: TextSizes.Title_2,
                weight: TextWidget.Bold_text,
              ),
              TextWidget(
                text: "Here is your financial over view",
                size: TextSizes.Title_3,
                weight: TextWidget.Bold_text,
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: "Current Balance",
                            size: TextSizes.Title_2,
                            weight: TextWidget.Medium_text,
                            color: AppColors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove_red_eye,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      TextWidget(
                        text: "₹24,400.00",
                        size: TextSizes.Heading_4,
                        weight: TextWidget.Bold_text,
                        color: AppColors.white,
                      ),
                      SizedBox(height: height * 0.01),
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
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Income",
                                    size: TextSizes.Title_3,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                  TextWidget(
                                    text: "₹12,800.00",
                                    size: TextSizes.Title_3,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                  TextWidget(
                                    text: "This Month",
                                    size: TextSizes.Title_3,
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
                                  size: 20,
                                  color: AppColors.expense,
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Expense",
                                    size: TextSizes.Title_3,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                  TextWidget(
                                    text: "₹12,800.00",
                                    size: TextSizes.Title_3,
                                    weight: TextWidget.Medium_text,
                                    color: AppColors.white,
                                  ),
                                  TextWidget(
                                    text: "This Month",
                                    size: TextSizes.Title_3,
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
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddTxn(isincome: false,),));
                    },
                    child: Container(
                      height: height*0.1,
                      width: width*0.2,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(width * 0.01),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          TextWidget(
                            text: "Add Txn",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: height*0.1,
                      width: width*0.2,
                      decoration: BoxDecoration(
                        color: AppColors.budget.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.pie_chart,
                              size: 20,
                              color: AppColors.budget,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          TextWidget(
                            text: "Budget",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: height*0.1,
                      width: width*0.2,
                      decoration: BoxDecoration(
                        color: AppColors.education.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(width * 0.01),
                            decoration: BoxDecoration(
                              color: AppColors.education,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.bar_chart,
                              size: 24,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          TextWidget(
                            text: "Reports",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: "Recent Transactions",
                              size: TextSizes.Title_2,
                              weight: TextWidget.Bold_text,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: TextWidget(
                                text: "View All",
                                size: TextSizes.Title_3,
                                weight: TextWidget.Bold_text,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),

                        // THESE ARE PLACEHOLDERS DATA WILL BE FETCHED FROM DATABASE
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: li.length,
                              itemBuilder: (context, index) {
                                var data = li[index];
                                bool isincome = data['isincome'];
                                return Padding(
                                  padding: EdgeInsets.symmetric(  vertical: height*0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               TextWidget(text: "${data['title']}", size: TextSizes.Title_3, weight: TextWidget.Medium_text),
                                               TextWidget(text: "${data['sub']}", size: TextSizes.Title_3, weight: TextWidget.Medium_text,color: AppColors.textSecondary,),
                                             ],
                                           ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          TextWidget(text: '${data['amount']}', size: TextSizes.Title_3, weight: TextWidget.Medium_text,color: isincome?AppColors.income:AppColors.expense),
                                          TextWidget(text: "${data['date']}", size: TextSizes.Title_3, weight: TextWidget.Medium_text,color: AppColors.textSecondary,),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                // height: height*0.1,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 0.2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.food.withValues(alpha: 0.2),
                          radius: 28,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.food,
                            child: Icon(
                              Icons.fastfood,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        TextWidget(text: "Food", size: TextSizes.Title_3, weight: TextWidget.normal_text),
                        TextWidget(text: "₹4320", size: TextSizes.Title_3, weight: TextWidget.normal_text,color: AppColors.textSecondary,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.transport.withValues(alpha: 0.2),
                          radius: 28,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.transport,
                            child: Icon(
                              Icons.train,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        TextWidget(text: "Transport", size: TextSizes.Title_3, weight: TextWidget.normal_text),
                        TextWidget(text: "₹4320", size: TextSizes.Title_3, weight: TextWidget.normal_text,color: AppColors.textSecondary,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.bills.withValues(alpha: 0.2),
                          radius: 28,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.bills,
                            child: Icon(
                              Icons.newspaper,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        TextWidget(text: "Biils", size: TextSizes.Title_3, weight: TextWidget.normal_text),
                        TextWidget(text: "₹4320", size: TextSizes.Title_3, weight: TextWidget.normal_text,color: AppColors.textSecondary,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.shopping.withValues(alpha: 0.2),
                          radius: 28,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.shopping,
                            child: Icon(
                              Icons.shopping_bag,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        TextWidget(text: "Shopping", size: TextSizes.Title_3, weight: TextWidget.normal_text),
                        TextWidget(text: "₹4320", size: TextSizes.Title_3, weight: TextWidget.normal_text,color: AppColors.textSecondary,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                          radius: 28,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.more_horiz,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        TextWidget(text: "Food", size: TextSizes.Title_3, weight: TextWidget.normal_text),
                        TextWidget(text: "₹4320", size: TextSizes.Title_3, weight: TextWidget.normal_text,color: AppColors.textSecondary,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
