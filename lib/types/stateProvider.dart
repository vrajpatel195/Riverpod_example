import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateProvider is great for storing simple state objects that can change, such as a counter value:
final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

//StateProvider is ideal for storing simple state variables, such as enums, strings, booleans, and numbers.
class StateProviderWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch the provider and rebuild when the value changes
    final counter = ref.watch(counterStateProvider);
    return ElevatedButton(
      // 2. use the value
      child: Text('Value: $counter'),
      // 3. change the state inside a button callback
      onPressed: () => ref.read(counterStateProvider.notifier).state++,
    );
  }
}
