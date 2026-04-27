import 'package:flutter/material.dart';
import 'app.dart';
import 'core/config/app_initializer.dart';

void main()async {
  await AppInitializer.init();
  runApp(const MyApp());
}

