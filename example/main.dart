import 'package:flutter/material.dart';
import 'package:value_watcher/value_watcher.dart';

final counter = ValueNotifier(0);

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.value++;
        },
      ),
      body: WatcherBuilder(
        builder: (context) {
          final value = context.listen(counter);
          return Text('value $value');
        },
      ),
    );
  }
}
