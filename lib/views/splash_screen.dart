import 'dart:async';
import 'package:flutter/material.dart';

import '../constants/images.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'views.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() async {
    NavigationService().pushReplacement(const DashBoard());
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              Center(
                child: Pulser(
                  duration: 800,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.3,
                    image: AssetImage(
                      logo,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
