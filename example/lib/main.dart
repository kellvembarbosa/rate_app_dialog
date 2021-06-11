import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_app_dialog/rate_app_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class AppController extends GetxController {
  final _count = 0.obs;

  get getCount => _count.value;
  increment() => _count.value++;
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample Example')),
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Welcome guest, Welcome guest, already clicked ${controller._count} times.',
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            OutlinedButton(
              onPressed: () => RateApp().requestDialog(
                context,
              ),
              child: Text('Open Dialog'),
            ),
            OutlinedButton(
              onPressed: () => RateApp().resetKeyAndValues(),
              child: Text('Reset Key/Values'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}
