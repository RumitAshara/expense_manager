import 'package:flutter/material.dart';
import 'package:expense_manager/core/constant/App_Colors.dart';

class Inputfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final Widget? prefixicon;
  final Widget? postfixicon;
  final bool isobscure;
  final TextInputType type;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final int maxlines;
  const Inputfield(
      {
        super.key,
        required this.type,
        required this.hinttext,
        this.prefixicon,
        this.postfixicon,
        required this.controller,
        this.isobscure = false,
        this.readOnly = false, // Default to false
        this.onTap,
        this.validator,
        this.maxlines = 1,
      });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    final bool istab = width > 480;
    return TextFormField(
      maxLines: maxlines,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      style: TextStyle(
          fontSize: 12
      ),
      obscureText: isobscure,
      controller: controller,
      keyboardType: type,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          filled: true,
          prefixIconConstraints: BoxConstraints(
            minWidth: width * 0.07,
            minHeight: width * 0.07,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: width * 0.07,
            minHeight: width * 0.07,
          ),
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                style: BorderStyle.solid,
                width: width * 0.003,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(istab?24:8),
            borderSide: BorderSide(
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              style: BorderStyle.solid,
              width: width * 0.004,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(istab?24:8),
            borderSide: BorderSide(
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              style: BorderStyle.solid,
              width: width * 0.003,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(istab?24:8),
            borderSide: BorderSide(
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              style: BorderStyle.solid,
              width: width * 0.003,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: istab ? height * 0.020 : height * 0.005,
            horizontal: width*0.04,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.04),
            child: prefixicon,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.04),
            child: postfixicon,
          ),
          hintText: hinttext,
          hintStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          )),
    );
  }
}
