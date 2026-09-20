import 'package:expense_manager/Database/controller/category_controller.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/core/constant/TextSize.dart';
import 'package:expense_manager/core/helpers/category_helper.dart';
import 'package:expense_manager/core/widgets/InputField.dart';
import 'package:expense_manager/core/widgets/TextWidget.dart';
import 'package:expense_manager/screens/Add_Category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatefulWidget {
  final bool isincome;
  const Categories({super.key,required this.isincome});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController _search = TextEditingController();
  final CategoryController controller = Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    controller.getCategoriesByType(
      widget.isincome ? 'income' : 'expense',
    );
  }
  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.background,
        backgroundColor: AppColors.background,
        title: TextWidget(text: "Manage Categories", size: TextSizes.Heading_4, weight: TextWidget.Bold_text),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: .start,
          spacing: height * 0.01,
          children: [
            TextWidget(
              text: 'Default Categories',
              size: TextSizes.Title_1,
              weight: TextWidget.Bold_text,
            ),
            TextWidget(
              text: 'These Categories are built-in and can\'t be deleted.',
              size: TextSizes.Title_3,
              weight: TextWidget.Bold_text,
              color: AppColors.textSecondary,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      final isdefault = category.isDefault;
                      return ListTile(
                        onTap: () {

                        },

                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CategoryHelper.getColor(category.color).withValues(
                              alpha: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            CategoryHelper.getIcon(category.icon),
                            color: CategoryHelper.getColor(category.color),
                          ),
                        ),

                        title: TextWidget(
                          text: category.name,
                          size: TextSizes.Title_2,
                          weight: TextWidget.Medium_text,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: width * 0.04,
                          children: [
                            isdefault?const Icon(
                              Icons.lock_outline,
                              size: 20,
                            ):InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    content:TextWidget(text: "Deleting ${category.name} category will erase all data for this category. Are you sure you want to delete this category?", size: TextSizes.Title_3, weight: TextWidget.Medium_text,maxline: 3,),
                                    title: TextWidget(text: "Warning", size: TextSizes.Title_2, weight: TextWidget.Medium_text,maxline: 3,),
                                    actions: [
                                      TextButton(onPressed: () async {
                                        final success = await controller.deleteCategory(category);
                                        if (success) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: TextWidget(
                                                text: "Category and its transactions deleted successfully",
                                                size: TextSizes.Title_3,
                                                weight: TextWidget.Medium_text,
                                                color: AppColors.background,
                                              ),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        }
                                      }, child: TextWidget(text: "Delete", size: TextSizes.Title_2, weight: TextWidget.Medium_text)),
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: TextWidget(text: "Cancel", size: TextSizes.Title_2, weight: TextWidget.Medium_text))
                                    ],
                                  );
                                },);
                              },
                                child: const Icon(Icons.delete_outline)),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          ],
                        ),
                      );
                    },

                    separatorBuilder: (context, index) {
                      return const Divider();
                    },

                    itemCount: controller.categories.length,
                  );
                })
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategory(isincome: widget.isincome,),)
                );
              },
              child: Row(
                mainAxisAlignment: .center,
                spacing: width * 0.04,
                children: [
                  Icon(Icons.add, color: AppColors.background),
                  TextWidget(
                    text: "Add Custom Category",
                    size: TextSizes.Title_3,
                    weight: TextWidget.Bold_text,
                    color: AppColors.background,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }
}