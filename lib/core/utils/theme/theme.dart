import 'package:fix_city/core/utils/theme/widget%20theme/appbar_theme.dart';
import 'package:fix_city/core/utils/theme/widget%20theme/elevated_button_theme.dart';
import 'package:fix_city/core/utils/theme/widget%20theme/outlined_button_theme.dart';
import 'package:fix_city/core/utils/theme/widget%20theme/text_field_theme.dart';
import 'package:fix_city/core/utils/theme/widget%20theme/text_theme.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class UAppTheme {
  UAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary: UColors.primary,
      secondary: UColors.primary,
    ),

    scaffoldBackgroundColor: UColors.white,
    disabledColor: Colors.grey,

    textTheme: UTextTheme.lightTextTheme,
    appBarTheme: UAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: UElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.lightOutlinedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary: UColors.primary,
      secondary: UColors.primary,
    ),

    scaffoldBackgroundColor: UColors.black,
    disabledColor: Colors.grey,

    textTheme: UTextTheme.darkTextTheme,
    appBarTheme: UAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: UElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.darkInputDecorationTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}