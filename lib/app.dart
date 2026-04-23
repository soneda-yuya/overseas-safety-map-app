import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root widget. In PR A this is a minimal placeholder; PR B replaces it with
/// the MaterialApp.router + go_router wiring from the design doc §1.7.
class OverseasSafetyMapApp extends ConsumerWidget {
  const OverseasSafetyMapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: '海外安全情報マップ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const _CoreWiredPlaceholder(),
    );
  }
}

/// PR A exit point: confirms the app compiles and that Firebase / Riverpod
/// wiring is in place. PR B will replace this with the real root scaffold.
class _CoreWiredPlaceholder extends StatelessWidget {
  const _CoreWiredPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('海外安全情報マップ')),
      body: const Center(
        child: Text(
          'Core wired.\nUI lands in PR B.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
