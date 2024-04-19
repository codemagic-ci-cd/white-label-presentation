import 'package:flutter/material.dart';

class AppSettings {
  late String kStatusBarHeader;
  late String kMainHeader;
  late String kSubHeader;
  late bool kShowAppBar;
  late Gradient kGradientStyle;
  late Color primaryColor;
  late Color scaffoldBackgroundColor;
  late String fontFamily;
  late Color buttonBackgroundColor;
  late Color buttonForegroundColor;
  late String hotelAddress;
  late String breakfastWeekdays;
  late String breakfastWeekends;
  late String breakfastLocation;

  AppSettings(
      {required this.kMainHeader,
      required this.kShowAppBar,
      required this.kStatusBarHeader,
      required this.kSubHeader,
      required this.kGradientStyle,
      required this.primaryColor,
      required this.scaffoldBackgroundColor,
      required this.fontFamily,
      required this.hotelAddress,
      required this.buttonForegroundColor,
      required this.buttonBackgroundColor,
      required this.breakfastWeekdays,
      required this.breakfastWeekends,
      required this.breakfastLocation});

  static Future<AppSettings> fromJson(Map<String, dynamic> json) async {
    String kMainHeader = const String.fromEnvironment('main_header');
    bool kShowAppBar = const bool.fromEnvironment('show_app_bar');
    String kStatusBarHeader = const String.fromEnvironment('status_bar_header');
    String kSubHeader = const String.fromEnvironment('sub_header');
    LinearGradient kGradientStyle = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(int.parse(const String.fromEnvironment('primary_color'))),
        Color(int.parse(const String.fromEnvironment('background_color'))),
      ],
    );
    Color primaryColor =
        Color(int.parse(const String.fromEnvironment('primary_color')));
    Color scaffoldBackgroundColor =
        Color(int.parse(const String.fromEnvironment('background_color')));
    String fontFamily = const String.fromEnvironment('font_family');
    Color buttonForegroundColor = Color(
        int.parse(const String.fromEnvironment('button_foreground_color')));
    Color buttonBackgroundColor = Color(
        int.parse(const String.fromEnvironment('button_background_color')));
    String hotelAddress = const String.fromEnvironment('hotel_address');
    String breakfastWeekdays =
        const String.fromEnvironment('breakfast_weekdays');
    String breakfastWeekends =
        const String.fromEnvironment('breakfast_weekends');
    String breakfastLocation =
        const String.fromEnvironment('breakfast_location');

    return AppSettings(
      kMainHeader: kMainHeader,
      kShowAppBar: kShowAppBar,
      kStatusBarHeader: kStatusBarHeader,
      kSubHeader: kSubHeader,
      kGradientStyle: kGradientStyle,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      fontFamily: fontFamily,
      buttonForegroundColor: buttonForegroundColor,
      buttonBackgroundColor: buttonBackgroundColor,
      hotelAddress: hotelAddress,
      breakfastWeekdays: breakfastWeekdays,
      breakfastWeekends: breakfastWeekends,
      breakfastLocation: breakfastLocation,
    );
  }
}
