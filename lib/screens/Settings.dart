import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:expense_manager/screens/Categories.dart';
import 'package:expense_manager/screens/Licenses.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Icon forward = Icon(Icons.arrow_forward_ios_rounded, size: 20);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.background,
        backgroundColor: AppColors.background,
         title: TextWidget(text: "Settings", size: TextSizes.Heading_4, weight: TextWidget.Bold_text),
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.01),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            spacing: height * 0.01,
            children: [
              // TextWidget(
              //   text: "App Preferences",
              //   size: TextSizes.Title_1,
              //   weight: TextWidget.Bold_text,
              //   color: AppColors.primary,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //     border: Border.all(color: AppColors.divider, width: 1),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: .start,
              //     mainAxisAlignment: .start,
              //     children: [
              //       ListTile(
              //         leading: const Icon(Icons.currency_rupee),
              //         title: TextWidget(
              //           text: "Currency",
              //           size: TextSizes.Title_2,
              //           weight: TextWidget.Medium_text,
              //         ),
              //         trailing: forward,
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: height * 0.01),
              TextWidget(
                text: "Data Management",
                size: TextSizes.Title_1,
                weight: TextWidget.Bold_text,
                color: AppColors.primary,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(isincome: true,),));
                      },
                      leading: const Icon(Icons.south_west),
                      title: TextWidget(
                        text: "Income Categories",
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: forward,
                    ),
                    Divider(color: AppColors.divider),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(isincome: false,),));
                      },
                      leading: const Icon(Icons.north_east),
                      title: TextWidget(
                        text: "Expense Categories",
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: forward,
                    ),
                    Divider(color: AppColors.divider),
                    ListTile(
                      leading: const Icon(Icons.backup_outlined),
                      title: TextWidget(
                        text: "Backup",
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: forward,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              TextWidget(
                text: "About",
                size: TextSizes.Title_1,
                weight: TextWidget.Bold_text,
                color: AppColors.primary,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: TextWidget(
                        text: "Privacy Policy",
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: forward,
                    ),
                    Divider(color: AppColors.divider),
                    ListTile(
                      leading: const Icon(Icons.sticky_note_2_outlined),
                      title: TextWidget(
                        text: "Terms & Conditions",
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: forward,
                    ),
                    Divider(color: AppColors.divider),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: TextWidget(
                        text: "Version",
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: Row(
                        spacing: width * 0.04,
                        mainAxisSize: .min,
                        children: [
                          TextWidget(
                            text: "1.0.0",
                            size: TextSizes.Title_2,
                            weight: TextWidget.Medium_text,
                            color: AppColors.primary,
                          ),
                          forward,
                        ],
                      ),
                    ),
                    Divider(color: AppColors.divider),
                    ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Licenses(),));
                      },
                      leading: const Icon(Icons.badge_outlined),
                      title: TextWidget(
                        text: "Licences",
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: forward,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
