import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Counter class using ChangeNotifier
class CounterNotifier extends ChangeNotifier {
  int _count = 0;

  int get count => _count; // Getter

  void increment() {
    _count++;
    notifyListeners(); // Notify UI to update
  }

  void decrement() {
    _count--;
    notifyListeners(); // Notify UI to update
  }
}

// Define ChangeNotifierProvider for CounterNotifier
final counterProvider = ChangeNotifierProvider((ref) => CounterNotifier());

class ChangeNotifierProviderWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider); // Watch counterProvider

    return Scaffold(
      appBar: AppBar(title: Text("ChangeNotifierProvider Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter: ${counter.count}", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider).increment(),
                  child: Text("+"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider).decrement(),
                  child: Text("-"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
