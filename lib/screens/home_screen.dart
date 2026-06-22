import 'package:flutter/material.dart';
import 'converter_screen.dart';
import 'rate_calculator_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ConverterScreen(),
    const RateCalculatorScreen(),
  ];

  final List<String> _titles = [
    'Tola Masha Ratti Converter',
    'Rate Calculator',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.swap_horiz),
            label: 'Converter',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate),
            label: 'Rate Calc',
          ),
        ],
      ),
    );
  }
}
