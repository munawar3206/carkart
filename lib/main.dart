import 'package:car/models/car.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'db/boxes.dart';

import 'homepage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CarAdapter());
  boxperson = await Hive.openBox<Car>('carbox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CarKart',
      home: HomePage(),
    );
  }
}
