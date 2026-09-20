import 'package:flutter/material.dart';

class Licenses extends StatelessWidget {
  const Licenses({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: "Expensio",
      applicationVersion: "1.0.0",
      // applicationIcon: Container(
      //     margin: EdgeInsets.all(8),
      //     width: 80,height:80,
      //     clipBehavior: Clip.antiAlias,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadiusGeometry.circular(16),
      //     ),
      //     child: Image.asset('Assets/logo.png',fit: BoxFit.cover,)
      // ),
      applicationLegalese: "© 2026 Expensio",
    );
  }
}
