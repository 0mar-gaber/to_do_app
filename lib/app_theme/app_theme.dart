import 'package:flutter/material.dart';
import 'package:to_do/colors/constant_colors.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(

    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appBarBackGroundColorLight,

        background: AppColors.backGroundColorLight,

        tertiary: AppColors.appBarBackGroundColorLight,
        error: AppColors.appBarTextColorLight,

        onBackground: AppColors.calendarBackGroundColorLight,
        onErrorContainer: AppColors.calendarSelectedTextColorLight,
        onSecondary: AppColors.calendarUnSelectedTextColorLight,
        onPrimary: AppColors.calendarTodayBackGroundColorLight,

        secondary: AppColors.taskBackGroundColorLight,
        primary: AppColors.taskPrimaryColorLight,
        errorContainer: AppColors.taskPrimaryOnDoneColorLight,
        primaryContainer: AppColors.taskSecondaryOnDoneColorLight,

        outline: AppColors.floatingButtonBackGroundColorLight,
        outlineVariant: AppColors.floatingButtonRoundedIconColorLight,

        inversePrimary: AppColors.navBarBackGroundColorLight,
        inverseSurface: AppColors.navBarSelectedIconColorLight,
        secondaryContainer: AppColors.navBarUnSelectedIconColorLight,

        onInverseSurface: AppColors.editSheetBackGroundColorLight,
        onPrimaryContainer: AppColors.editSheetButtonBackGroundColorLight,
        onSecondaryContainer: AppColors.editSheetButtonTextColorLight,
        onSurface: AppColors.editSheetTextColorLight,

        onSurfaceVariant: AppColors.settingButtonBackGroundColorLight,
        onTertiary: AppColors.settingButtonTextColorLight,
        onTertiaryContainer: AppColors.settingButtonTextRoundedColorLight

    ),
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: AppColors.appBarTextColorLight,fontWeight: FontWeight.w600),
        backgroundColor: Colors.transparent
      
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.navBarSelectedIconColorLight,
      unselectedItemColor:AppColors.navBarUnSelectedIconColorLight,

    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.floatingButtonBackGroundColorLight,
    ),



  );

  static ThemeData darkTheme = ThemeData(

      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appBarBackGroundColorDark,

          background: AppColors.backGroundColorDark,

          tertiary: AppColors.appBarBackGroundColorDark,
          error: AppColors.appBarTextColorDark,

          onBackground: AppColors.calendarBackGroundColorDark,
          onErrorContainer: AppColors.calendarSelectedTextColorDark,
          onSecondary: AppColors.calendarUnSelectedTextColorDark,
          onPrimary: AppColors.calendarTodayBackGroundColorDark,

          secondary: AppColors.taskBackGroundColorDark,
          primary: AppColors.taskPrimaryColorDark,
          errorContainer: AppColors.taskPrimaryOnDoneColorDark,
          primaryContainer: AppColors.taskSecondaryOnDoneColorDark,

          outline: AppColors.floatingButtonBackGroundColorDark,
          outlineVariant: AppColors.floatingButtonRoundedIconColorDark,

          inversePrimary: AppColors.navBarBackGroundColorDark,
          inverseSurface: AppColors.navBarSelectedIconColorDark,
          secondaryContainer: AppColors.navBarUnSelectedIconColorDark,

          onInverseSurface: AppColors.editSheetBackGroundColorDark,
          onPrimaryContainer: AppColors.editSheetButtonBackGroundColorDark,
          onSecondaryContainer: AppColors.editSheetButtonTextColorDark,
          onSurface: AppColors.editSheetTextColorDark,

          onSurfaceVariant: AppColors.settingButtonBackGroundColorDark,
          onTertiary: AppColors.settingButtonTextColorDark,
          onTertiaryContainer: AppColors.settingButtonTextRoundedColorDark

      ),
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: AppColors.appBarTextColorDark,fontWeight: FontWeight.w600),
        backgroundColor: Colors.transparent
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.navBarSelectedIconColorDark,
        unselectedItemColor:AppColors.navBarUnSelectedIconColorDark,

      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.floatingButtonBackGroundColorDark,
      ),



  );



}