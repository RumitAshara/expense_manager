import 'package:flutter/cupertino.dart';

class TextSizes{
  static late double height;
  static late double width;
  static double Heading_1 = 32; ///8% of the Width Size 32px irrelevant
  static double Heading_2 = 28; ///7% of the Width Size 28px still irrelevant
  static double Heading_3 =  24; ///6% of the Width Size 24px for bigger heading but irrelevant
  static double Heading_4 = 22; ///5.5% of the Width Size 22px for bigger heading but irrelevant
  static double Heading_5 = 20; ///5% of the Width Size 20px for bigger Heading Exelent Choice
  static double Title_1 = 16; ///4% of the Width Size 16px for Title Such as Screen Title Exelent Choice
  static double Title_2 = 14; /// 3.5% of the Width Size 14px for Sub-Title Such as Screen Sub-Title Exelent Choice
  static double Title_3 = 12; /// 3% of the Width Size 12px for Sub-Title Such as Screen Sub-Title Exelent Choice
  static GetFontSize(BuildContext context){
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
    // bool isTablet = Device.get().isTablet;
    if(width > 480){
      //for tablets
      Heading_1 = width*0.06; ///6% of the Width Size 32px irrelevant
      Heading_2 = width*0.05; ///5% of the Width Size 28px still irrelevant
      Heading_3 =  width*0.04; ///4% of the Width Size 24px for bigger heading but irrelevant
      Heading_4 = width*0.035; ///3.5% of the Width Size 22px for bigger heading but irrelevant
      Heading_5 = width*0.03; ///3% of the Width Size 20px for bigger Heading Exelent Choice
      Title_1 = width*0.025; ///2.5% of the Width Size 16px for Title Such as Screen Title Exelent Choice
      Title_2 = width*0.025; /// 2% of the Width Size 14px for Sub-Title Such as Screen Sub-Title Exelent Choice
      Title_3 = width*0.02; /// 1% of the Width Size 14px for Sub-Title Such as Screen Sub-Title Exelent Choice
    }else{
      //for mobiles
      Heading_1 = width*0.08; ///8% of the Width Size 32px irrelevant
      Heading_2 = width*0.07; ///7% of the Width Size 28px still irrelevant
      Heading_3 =  width*0.06; ///6% of the Width Size 24px for bigger heading but irrelevant
      Heading_4 = width*0.055; ///5.5% of the Width Size 22px for bigger heading but irrelevant
      Heading_5 = width*0.05; ///5% of the Width Size 20px for bigger Heading Exelent Choice
      Title_1 = width*0.04; ///4% of the Width Size 16px for Title Such as Screen Title Exelent Choice
      Title_2 = width*0.035; /// 3.5% of the Width Size 14px for Sub-Title Such as Screen Sub-Title Exelent Choice
      Title_3 = width*0.03; /// 3% of the Width Size 14px for Sub-Title Such as Screen Sub-Title Exelent Choice
    }
  }
}
