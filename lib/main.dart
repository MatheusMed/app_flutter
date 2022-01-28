import 'package:app/app/controllers/crud_controller.dart';
import 'package:app/app/pages/create/create.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/pages/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<CrudController>(() => CrudController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Crud',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}
