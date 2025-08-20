import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remago/core/services/services.dart';
import 'core/constant/routes.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CountDown App",
      initialRoute: AppRoute.homepage,
      getPages: routes,
    );
  }
}
