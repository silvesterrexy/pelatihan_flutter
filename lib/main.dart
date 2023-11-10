// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pelatihan_flutter/config/SizeConfig.dart';
import 'package:pelatihan_flutter/splashScreen/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(
      const MyApp(),
    );
    // initializeDateFormatting().then((_) => runApp(const MyApp()));
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: GetMaterialApp(
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent, // <-- SEE HERE
                      statusBarIconBrightness: Brightness
                          .light, //<-- For Android SEE HERE (dark icons)
                      statusBarBrightness:
                          Brightness.dark, //<-- For iOS SEE HERE (dark icons)
                      // systemNavigationBarColor: ColorsMain.mainColor.withOpacity(0.8),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    centerTitle: false,
                  ),
                  dividerColor: Colors.transparent,
                  useMaterial3: true,
                  dialogTheme: const DialogTheme(
                    backgroundColor: Colors.white,
                  ),
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                    // focusColor: Colors.white,
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0XFF727884),
                    // elevation: 0,
                    // shape: CircleBorder(),
                  ),
                  dialogBackgroundColor: Colors.white,
                  platform: (Platform.isAndroid)
                      ? TargetPlatform.android
                      : TargetPlatform.iOS,
                  bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
                localizationsDelegates: const [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  MonthYearPickerLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
