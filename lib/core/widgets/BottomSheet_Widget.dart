import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});
  static List exp_cat = ["Foods & Drink","Shopping","Transport","Bills & Utilities","Travel","Health","Education","Entertainment","Others"];
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(text: "Select Category", size: TextSizes.Title_1, weight: TextWidget.Medium_text),
        TextWidget(text: "Choose a category for this transaction", size: TextSizes.Title_3, weight: TextWidget.Medium_text),
        ListView.builder(
          shrinkWrap: true,
          itemCount: exp_cat.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: TextWidget(text: exp_cat[index], size: TextSizes.Title_3, weight: TextWidget.Medium_text),
              leading: ,
            );
          }
        )
      ],
    );
  }
}
