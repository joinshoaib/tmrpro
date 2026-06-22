import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/converter_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GoldConverterApp());
}

class GoldConverterApp extends StatelessWidget {
  const GoldConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConverterProvider(),
      child: MaterialApp(
        title: 'Gold Converter Pro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFD4AF37),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          cardTheme: const CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFD4AF37),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          cardTheme: const CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
