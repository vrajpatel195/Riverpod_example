import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StreamProvider that emits a random number every second
final randomNumberProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
    Duration(seconds: 1),
    (count) => Random().nextInt(100), // Generate a random number
  );
});

class StreamProviderWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(randomNumberProvider);

    return Scaffold(
      appBar: AppBar(title: Text("StreamProvider Example")),
      body: Center(
        child: asyncValue.when(
          data: (value) =>
              Text("Random Number: $value", style: TextStyle(fontSize: 24)),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}
