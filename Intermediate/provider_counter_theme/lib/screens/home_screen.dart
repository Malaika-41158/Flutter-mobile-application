import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Demo"),
        actions: [
          Switch(
            value: themeProvider.isDark,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter Value:", style: Theme.of(context).textTheme.headlineSmall),
            Text("${counter.count}", style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: counter.increment, child: const Text("+")),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: counter.decrement, child: const Text("-")),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: counter.reset, child: const Text("Reset")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}