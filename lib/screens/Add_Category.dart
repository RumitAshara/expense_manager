import 'package:expense_manager/Database/controller/category_controller.dart';
import 'package:expense_manager/Database/models/category_model.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/Expense_Categories_Icons.dart';
import 'package:expense_manager/core/constant/Income_Category_Icons.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/widgets/InputField.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddCategory extends StatefulWidget {
  final bool isincome;
  const AddCategory({super.key, required this.isincome});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final CategoryController categoryController = Get.find<CategoryController>();
  static const List<Color> iconColors = [
    Color(0xFFE57373), // Red
    Color(0xFF42A5F5), // Blue
    Color(0xFFFFB74D), // Orange
    Color(0xFF66BB6A), // Green
    Color(0xFFAB47BC), // Purple
    Color(0xFF26A69A), // Teal
    Color(0xFFEC407A), // Pink
    Color(0xFF78909C), // Blue Grey
    Color(0xFFFFCA28), // Amber
    Color(0xFF5C6BC0), // Indigo
  ];
  bool showMore = false;
  TextEditingController cat_Controller = TextEditingController();
  int _selectedIndex = 0;
  late final List<IconData> icons;
  late final List<String> iconNames;
  int chars = 0;
  late final String s;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isincome) {
      iconNames = IncomeCategoryIcons.all.keys.toList();
      icons = IncomeCategoryIcons.all.values.toList();
    } else {
      iconNames = ExpenseCategoryIcons.all.keys.toList();
      icons = ExpenseCategoryIcons.all.values.toList();
    }
    s = widget.isincome ? "Income" : "Expense";
  }
  @override
  Widget build(BuildContext context) {
    final selectedColor = iconColors[
    _selectedIndex % iconColors.length
    ];

    final selectedIcon = icons[_selectedIndex];
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.background,
        backgroundColor: AppColors.background,
        title: TextWidget(text: "Create ${s} Category", size: TextSizes.Heading_4, weight: TextWidget.Bold_text),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            spacing: height * 0.01,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                child: Column(
                  spacing: height * 0.01,
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: height * 0.01),
                    TextWidget(
                      text: "Category Name",
                      size: TextSizes.Title_1,
                      weight: TextWidget.Bold_text,
                    ),
                    Inputfield(
                      type: TextInputType.text,
                      hinttext: "Enter category name",
                      controller: cat_Controller,
                      onChanged: (value) {
                        setState(() {
                          chars = value.length;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextWidget(
                        text: "$chars/30",
                        size: TextSizes.Title_3,
                        weight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                  ],
                ),
              ),
              TextWidget(
                text: "Choose Icon",
                size: TextSizes.Title_1,
                weight: TextWidget.Bold_text,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                ),
                itemCount: showMore
                    ? icons.length
                    : (icons.length > 18 ? 18 : icons.length),
                itemBuilder: (context, index) {
                  final color = iconColors[index % iconColors.length];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: _selectedIndex == index
                            ? Border.all(color: color)
                            : null,
                      ),
                      child: Icon(icons[index], color: color),
                    ),
                  );
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                  elevation: 0,
                  fixedSize: Size.fromHeight(height * 0.03),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: width * 0.04,
                  children: [
                    Icon(Icons.photo_outlined, color: AppColors.primary),
                    TextWidget(
                      text: showMore ? "Show Less" : "Show More",
                      size: TextSizes.Title_3,
                      weight: TextWidget.Bold_text,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    TextWidget(
                      text: "Preview",
                      size: TextSizes.Title_1,
                      weight: TextWidget.Bold_text,
                    ),
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: selectedColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          selectedIcon,
                          color: selectedColor,
                        ),
                      ),
                      title: TextWidget(
                        text: cat_Controller.text.toString().isEmpty? "Category Name":cat_Controller.text.toString(),
                        size: TextSizes.Title_2,
                        weight: TextWidget.Medium_text,
                      ),
                      trailing: Row(
                        mainAxisSize: .min,
                        spacing: width * 0.04,
                        children: [
                          Icon(Icons.lock_outline, size: 20),
                          Icon(Icons.arrow_forward_ios, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  fixedSize: Size.fromHeight(height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                onPressed: () async {
                  final categoryName = cat_Controller.text.trim();
                  if (categoryName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: TextWidget(
                          text: "Please enter a category name",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                          color: AppColors.background,
                        ),
                      ),
                    );
                    return;
                  }

                  if (categoryName.length > 30) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: TextWidget(
                          text: "Category name cannot exceed 30 characters",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                          color: AppColors.background,
                        ),
                      ),
                    );
                    return;
                  }

                  try {
                    final selectedColor = iconColors[_selectedIndex % iconColors.length];
                    final colorHex = '#${selectedColor.value.toRadixString(16).substring(2).toUpperCase()}';
                    final iconName = iconNames[_selectedIndex];

                    final now = DateTime.now().toIso8601String();

                    final newCategory = CategoryModel(
                      name: categoryName,
                      type: widget.isincome ? 'income' : 'expense',
                      icon: iconName,
                      color: colorHex,
                      isDefault: false,
                      createdAt: now,
                      updatedAt: now,
                    );

                    final success = await categoryController.addCategory(newCategory);

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget(
                            text: "Category created successfully",
                            size: TextSizes.Title_3,
                            weight: TextWidget.Medium_text,
                            color: AppColors.background,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: TextWidget(
                          text: "Failed to create category",
                          size: TextSizes.Title_3,
                          weight: TextWidget.Medium_text,
                          color: AppColors.background,
                        ),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: width * 0.04,
                  children: [
                    Icon(Icons.add,color: AppColors.background,),
                    TextWidget(
                      text: "Create Category",
                      size: TextSizes.Title_3,
                      weight: TextWidget.Bold_text,
                      color: AppColors.background,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: Size.fromHeight(height * 0.06),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      side: BorderSide(
                          width: 1,
                          color: AppColors.divider
                      )
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: width * 0.04,
                  children: [
                    Icon(Icons.close,),
                    TextWidget(
                      text: "Cancel",
                      size: TextSizes.Title_3,
                      weight: TextWidget.Bold_text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}