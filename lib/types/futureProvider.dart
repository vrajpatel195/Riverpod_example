import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Define the Future that fetches data
Future<String> fetchData() async {
  // Simulate an asynchronous operation (e.g., API call)
  await Future.delayed(const Duration(seconds: 2)); // Simulate a 2-second delay
  // For demonstration, I am returning a hardcoded string. In real life, you would fetch this from an API.
  return 'Data from the future!';
  // throw Exception('Failed to load data'); // Example of error handling
}

// 2. Create a FutureProvider
final dataProvider = FutureProvider<String>((ref) async {
  return fetchData();
});

// 3. Use the FutureProvider in a Widget
class FutureProviderWidget extends ConsumerWidget {
  const FutureProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('FutureProvider Example')),
      body: Center(
        child: asyncValue.when(
          data: (data) => Text(data, style: const TextStyle(fontSize: 20)),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'), // Handle errors
        ),
      ),
    );
  }
}

// Explanation:

// fetchData() Function: This asynchronous function simulates fetching data.  In a real application, this is where you'd make your API call or perform other asynchronous tasks.  I've added a 2-second delay to demonstrate the asynchronous nature.  Critically, in a real app, you would replace the hardcoded string with the data from the API.  I've also included an example of how to throw an exception, which is important for error handling.

// dataProvider (FutureProvider): This is the core of the example.  FutureProvider takes a function that returns a Future.  Riverpod will automatically manage the state of this future (loading, data, error).  The ref parameter allows you to access other providers if needed (e.g., for authentication or configuration).

// MyWidget (ConsumerWidget): This widget uses ref.watch(dataProvider) to listen to the FutureProvider.  asyncValue will be an AsyncValue<String>.

// asyncValue.when(): This is the most important part for handling the asynchronous state.  when() forces you to handle all three possible states:

// data: The future completed successfully, and data contains the result (the string in this case).
// loading: The future is still running. You typically show a loading indicator.
// error: The future completed with an error. error contains the error object, and stackTrace provides the stack trace for debugging.
// Error Handling: The error case in asyncValue.when() is crucial.  Always handle potential errors to provide a good user experience.  You might show an error message, retry the operation, or take other appropriate actions.

// ProviderScope: The ProviderScope is essential. It makes Riverpod providers available to your widget tree.

// How it works:

// When MyWidget is built, ref.watch(dataProvider) starts listening to the FutureProvider.
// The FutureProvider calls fetchData().
// While fetchData() is running, asyncValue is in the loading state, and the CircularProgressIndicator is shown.
// When fetchData() completes successfully, asyncValue transitions to the data state, and the text widget displays the data.
// If fetchData() throws an exception, asyncValue transitions to the error state, and the error message is displayed.
// This example demonstrates the basic usage of FutureProvider.  In real-world applications, you'll likely be fetching data from an API, and you might need to combine FutureProvider with other providers (e.g., StateNotifierProvider for managing more complex state).  Remember to handle errors gracefully.
