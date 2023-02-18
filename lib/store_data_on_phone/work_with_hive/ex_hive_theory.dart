import 'package:flutter/material.dart';
import 'package:flutter_study_data/store_data_on_phone/work_with_hive/ex_widget_model.dart';

class ExampleHiveWidget extends StatefulWidget {
  const ExampleHiveWidget({Key? key}) : super(key: key);

  @override
  State<ExampleHiveWidget> createState() => _ExampleHiveWidgetState();
}

class _ExampleHiveWidgetState extends State<ExampleHiveWidget> {
  final model = ExampleWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: model.doSome,
              child: const Text('Добавить'),
            ),
            ElevatedButton(
              onPressed: model.setup,
              child: const Text('Настроить'),
            ),
          ],
        ),
      ),
    );
  }
}
