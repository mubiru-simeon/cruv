import 'package:cruv/models/train_selection.dart';
import 'package:cruv/theming/theme_controller.dart';
import 'package:cruv/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart';
import 'services/services.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(capitalizedAppName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(builder: (context, brightness) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TrainSelection(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          title: capitalizedAppName,
          theme: ThemeData(
            brightness: brightness,
            /* inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: standardBorderRadius,
              ),
            ), */
            primarySwatch: primaryColor,
          ),
          home: const SplashScreenView(),
        ),
      );
    });
  }
}
