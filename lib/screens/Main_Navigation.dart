import 'package:expense_manager/core/constant/App_Colors.dart';
import 'package:expense_manager/screens/Add_Txn.dart';
import 'package:expense_manager/screens/Dashboard.dart';
import 'package:expense_manager/screens/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> with WidgetsBindingObserver{
  DateTime? backgroundTime;
  final List<Widget> screens = [
    Dashboard(),
    // Addpass(),
    AddTxn(isincome: true),
    // AppLockTime(),
    Settings(),
  ];
  int currentIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
                backgroundColor: theme.colorScheme.surface,
                indicatorColor: AppColors.primaryDark.withValues(alpha: 0),
                labelTextStyle: WidgetStateProperty.resolveWith((states){
                  return TextStyle(
                    color: states.contains(WidgetState.selected)
                        ? AppColors.primary
                        : theme.colorScheme.onSurfaceVariant,
                  );
                }),
                iconTheme: WidgetStateProperty.resolveWith((states){
                  return IconThemeData(
                    color: states.contains(WidgetState.selected)? AppColors.primary:AppColors.primaryDark,
                  );
                })
            ),
            child: NavigationBar(
              height: 70,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              selectedIndex: currentIndex,
              // indicatorColor: AppColors.primaryDark.withValues(alpha: 0),
              onDestinationSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              },

              destinations : const [
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view_rounded,),
                  label: "Dashboard",
                ),
                NavigationDestination(
                  icon: Icon(Icons.upload_outlined),
                  selectedIcon: Icon(Icons.upload,),
                  label: "Add Txn",
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings,),
                  label: "Settings",
                ),
              ],
            ),),
        )
    );
  }
}
