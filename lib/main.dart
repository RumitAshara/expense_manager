import 'package:expense_manager/binding/initial_binding.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/screens/Add_Category.dart';
import 'package:expense_manager/screens/Add_Txn.dart';
import 'package:expense_manager/screens/Dashboard.dart';
import 'package:expense_manager/screens/Main_Navigation.dart';
import 'package:expense_manager/screens/Settings.dart';
import 'package:expense_manager/screens/Transaction_Details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: Settings(),
      // home: AddCategory(),
      // home: TransactionDetails(),
      home: MainNavigationScreen(),
      // home: Dashboard(),
      // home: AddTxn(),
    );
  }
}