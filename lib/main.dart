import 'package:flutter/material.dart';
import 'package:flutter_study_data/store_data_on_phone/work_with_hive/ex_hive_theory.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  const app = MaterialApp(
    home: ExampleHiveWidget(),
  );
  runApp(app);
}
