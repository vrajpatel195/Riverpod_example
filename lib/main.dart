import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/types/provider.dart';

import 'types/changeNotifierProvider.dart';
import 'types/futureProvider.dart';
import 'types/stateNotifierProvider.dart';
import 'types/stateProvider.dart';
import 'types/streamProvider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HelloWorldWidget(),
    );
  }
}

// Using a ConsumerWidget
// final helloWorldProvider = Provider<String>((_) => 'Hello world');

// // 1. widget class now extends [ConsumerWidget]
// class HelloWorldWidget extends ConsumerWidget {
//   @override
//   // 2. build method has an extra [WidgetRef] argument
//   Widget build(BuildContext context, WidgetRef ref) {
//     // 3. use ref.watch() to get the value of the provider
//     final helloWorld = ref.watch(helloWorldProvider);
//     return Text(helloWorld);
//   }
// }

//Using a Consumer
// final helloWorldProvider = Provider<String>((_) => 'Hello world');

// class HelloWorldWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       // 1. Add a Consumer
//       body: Consumer(
//         // 2. specify the builder and obtain a WidgetRef
//         builder: (_, WidgetRef ref, __) {
//           // 3. use ref.watch() to get the value of the provider
//           final helloWorld = ref.watch(helloWorldProvider);
//           return Text(helloWorld);
//         },
//       ),
//     );
//   }
// }

//Using ConsumerStatefulWidget & ConsumerState
// final helloWorldProvider = Provider<String>((_) => 'Hello world');

// // 1. extend [ConsumerStatefulWidget]
// class HelloWorldWidget extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<HelloWorldWidget> createState() => _HelloWorldWidgetState();
// }

// // 2. extend [ConsumerState]
// class _HelloWorldWidgetState extends ConsumerState<HelloWorldWidget> {
//   @override
//   void initState() {
//     super.initState();
//     // 3. if needed, we can read the provider inside initState
//     final helloWorld = ref.read(helloWorldProvider);
//     print(helloWorld); // "Hello world"
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 4. use ref.watch() to get the value of the provider
//     final helloWorld = ref.watch(helloWorldProvider);
//     return Text(helloWorld);
//   }
// }

class HelloWorldWidget extends StatelessWidget {
  const HelloWorldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Types of Riverpord '))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildElevatedButton(
              text: 'Provider',
              color: Colors.blue,
              icon: Icons.category,
              fontSize: 20,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ProviderRiverpod()),
              ),
            ),
            buildElevatedButton(
              text: 'StateProvider',
              color: Colors.green,
              fontSize: 20,
              icon: Icons.toggle_on,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => StateProviderWidget()),
              ),
            ),
            buildElevatedButton(
              text: 'StateNotifierProvider',
              color: Colors.orange,
              icon: Icons.notifications_active,
              fontSize: 20,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => StateNotifierProviderWidget()),
              ),
            ),
            buildElevatedButton(
              text: 'FutureProvider',
              color: Colors.purple,
              icon: Icons.access_time,
              fontSize: 20,
              elevation: 10,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FutureProviderWidget()),
              ),
            ),
            buildElevatedButton(
              text: 'StreamProvider',
              color: Colors.red,
              fontSize: 20,
              icon: Icons.wifi_tethering,
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => StreamProviderWidget())),
            ),
            buildGradientElevatedButton(
              text: 'ChangeNotifierProvider',
              gradient:
                  const LinearGradient(colors: [Colors.pink, Colors.blue]),
              fontSize: 20,
              icon: Icons.sync,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => ChangeNotifierProviderWidget()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton({
    required String text,
    required VoidCallback? onPressed,
    Color? color,
    double? borderRadius,
    IconData? icon,
    double? elevation,
    double? fontSize,
    Color? borderColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          elevation: elevation ?? 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            side: borderColor != null
                ? BorderSide(color: borderColor)
                : BorderSide.none,
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(text,
                      style: TextStyle(
                          fontSize: fontSize ?? 16, color: Colors.white)),
                ],
              )
            : Text(text,
                style:
                    TextStyle(fontSize: fontSize ?? 16, color: Colors.white)),
      ),
    );
  }

  Widget buildGradientElevatedButton({
    required String text,
    required LinearGradient gradient,
    required VoidCallback? onPressed,
    IconData? icon,
    double? fontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(text,
                        style: TextStyle(
                            fontSize: fontSize ?? 16, color: Colors.white)),
                  ],
                )
              : Text(text,
                  style:
                      TextStyle(fontSize: fontSize ?? 16, color: Colors.white)),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
