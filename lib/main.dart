import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';

import 'core/services/routeGenerator/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital HR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: RouteGenerator.navigatorKey,
      initialRoute: RouteGenerator.kSplashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

