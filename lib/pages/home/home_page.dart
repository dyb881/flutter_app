import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_app/stores/stores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onTap() {
    Get.toNamed('/user');
  }

  @override
  Widget build(BuildContext context) {
    final Stores s = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _onTap,
              child: Text(
                'You have pushed the button this many times:',
              ),
            ),
            Obx(
              () => Text(
                '${s.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: s.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
