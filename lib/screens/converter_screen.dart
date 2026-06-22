import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Grams to TMR Card
          _buildGramsToTMRCard(context),
          const SizedBox(height: 20),
          // TMR to Grams Card
          _buildTMRToGramsCard(context),
        ],
      ),
    );
  }

  Widget _buildGramsToTMRCard(BuildContext context) {
    final provider = context.read<ConverterProvider>();
    final gramsController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.scale, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Converter',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Grams → Tola-Masha-Ratti',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            TextField(
              controller: gramsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Grams',
                prefixIcon: const Icon(Icons.line_weight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixText: 'g',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  if (gramsController.text.isNotEmpty) {
                    provider.convertGramsToTMR(
                      double.parse(gramsController.text),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Convert'),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ConverterProvider>(
              builder: (context, provider, child) {
                if (provider.tmrResult.isEmpty) return const SizedBox.shrink();
                return _buildResultGrid(provider.tmrResult);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTMRToGramsCard(BuildContext context) {
    final provider = context.read<ConverterProvider>();
    final tolaController = TextEditingController();
    final mashaController = TextEditingController();
    final rattiController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.scale, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Converter',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Tola-Masha-Ratti → Grams',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tolaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Tola',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: mashaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Masha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: rattiController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Ratti',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  provider.convertTMRToGrams(
                    int.parse(
                      tolaController.text.isEmpty ? '0' : tolaController.text,
                    ),
                    int.parse(
                      mashaController.text.isEmpty ? '0' : mashaController.text,
                    ),
                    double.parse(
                      rattiController.text.isEmpty ? '0' : rattiController.text,
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Convert'),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ConverterProvider>(
              builder: (context, provider, child) {
                if (provider.gramsResult == 0) return const SizedBox.shrink();
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Result',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${provider.gramsResult.toStringAsFixed(3)} grams',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultGrid(Map<String, dynamic> result) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        children: [
          const Text(
            'Result',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildResultItem('Tola', result['tola'].toString(), 'Tola'),
              _buildResultItem('Masha', result['masha'].toString(), 'Masha'),
              _buildResultItem('Ratti', result['ratti'], 'Ratti'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB8860B),
          ),
        ),
        Text(
          '$label ($unit)',
          style: const TextStyle(fontSize: 12, color: Colors.brown),
        ),
      ],
    );
  }
}
