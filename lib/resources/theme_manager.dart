import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkGrey,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    // ripple effect color

    //  cardview theme
    cardTheme: CardThemeData(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(
          color: ColorManager.lightPrimary, fontSize: FontSize.s16),
    ),

    //  button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s17),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    //  text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      bodyLarge: getRegularStyle(color: ColorManager.grey1),
      bodySmall: getRegularStyle(color: ColorManager.grey),
      bodyMedium:
          getRegularStyle(color: ColorManager.grey2, fontSize: FontSize.s12),
      labelSmall: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s12,
      ),
    ),

    //  input decoration theme (text from fild)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      labelStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      errorStyle: getRegularStyle(color: ColorManager.error),
    ),
  );
}

/// Dark Theme for the application
ThemeData getDarkApplicationTheme() {
  return ThemeData(
    brightness: Brightness.dark,

    // main colors for dark theme
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.white,
    disabledColor: ColorManager.darkGrey,
    splashColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.darkBackground,
    canvasColor: ColorManager.darkSurface,

    // cardview theme for dark
    cardTheme: CardThemeData(
      color: ColorManager.darkSurface,
      shadowColor: ColorManager.black,
      elevation: AppSize.s4,
    ),

    // app bar theme for dark
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.darkSurface,
      elevation: AppSize.s4,
      shadowColor: ColorManager.black,
      titleTextStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
      iconTheme: IconThemeData(color: ColorManager.white),
      actionsIconTheme: IconThemeData(color: ColorManager.white),
    ),

    // button theme for dark
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.darkGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s17),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // text theme for dark
    textTheme: TextTheme(
      displayLarge:
          getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      bodyLarge: getRegularStyle(color: ColorManager.lightGrey),
      bodySmall: getRegularStyle(color: ColorManager.grey),
      bodyMedium: getRegularStyle(
          color: ColorManager.lightGrey, fontSize: FontSize.s12),
      labelSmall: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s12,
      ),
    ),

    // input decoration theme for dark
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle: getRegularStyle(
          color: ColorManager.lightGrey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),

      // Uncomment and customize borders if needed
      // enabledBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: ColorManager.darkGrey, width: AppSize.s1_5),
      //   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
      //   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      // ),
      // errorBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
      //   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      // ),
      // focusedErrorBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
      //   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      // ),
    ),

    // bottom navigation theme for dark
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.darkSurface,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.grey,
    ),

    // drawer theme for dark
    drawerTheme: DrawerThemeData(
      backgroundColor: ColorManager.darkSurface,
    ),

    // dialog theme for dark
    dialogTheme: DialogThemeData(
      backgroundColor: ColorManager.darkSurface,
      titleTextStyle:
          getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
      contentTextStyle: getRegularStyle(
          color: ColorManager.lightGrey, fontSize: FontSize.s14),
    ),

    // switch theme for dark
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorManager.primary;
        }
        return ColorManager.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorManager.primary.withOpacity(0.5);
        }
        return ColorManager.darkGrey;
      }),
    ),

    // icon theme for dark
    iconTheme: IconThemeData(
      color: ColorManager.white,
    ),
  );
}
