import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';

class RateCalculatorScreen extends StatelessWidget {
  const RateCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildMoneyToGoldCard(context),
          const SizedBox(height: 20),
          _buildGoldToMoneyCard(context),
        ],
      ),
    );
  }

  Widget _buildMoneyToGoldCard(BuildContext context) {
    final provider = context.read<ConverterProvider>();
    final amountController = TextEditingController();
    final rateController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Rate Calculator',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Money → Gold', style: Theme.of(context).textTheme.titleLarge),
            const Divider(height: 24),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Your Amount (PKR/INR/etc)',
                prefixIcon: const Icon(Icons.money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Gold Rate per Tola',
                prefixIcon: const Icon(Icons.trending_up),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixText: '/ Tola',
                helperText: 'Enter market rate for 1 Tola',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  if (amountController.text.isNotEmpty &&
                      rateController.text.isNotEmpty) {
                    provider.calculateMoneyToGold(
                      double.parse(amountController.text),
                      double.parse(rateController.text),
                    );
                  }
                },
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate Gold Quantity'),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ConverterProvider>(
              builder: (context, provider, child) {
                if (provider.moneyToGoldResult.isEmpty) {
                  return const SizedBox.shrink();
                }
                final result = provider.moneyToGoldResult;
                final tmr = result['tmr'] as Map<String, dynamic>;

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'You can buy',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${result['grams']} grams',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildGoldItem('Tola', tmr['tola'].toString()),
                            _buildGoldItem('Masha', tmr['masha'].toString()),
                            _buildGoldItem('Ratti', tmr['ratti']),
                          ],
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

  Widget _buildGoldToMoneyCard(BuildContext context) {
    final provider = context.read<ConverterProvider>();
    final gramsController = TextEditingController();
    final rateController = TextEditingController();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Rate Calculator',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Gold → Money', style: Theme.of(context).textTheme.titleLarge),
            const Divider(height: 24),
            TextField(
              controller: gramsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Gold in Grams',
                prefixIcon: const Icon(Icons.line_weight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Gold Rate per Tola',
                prefixIcon: const Icon(Icons.trending_up),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixText: '/ Tola',
                helperText: 'Enter market rate for 1 Tola',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  if (gramsController.text.isNotEmpty &&
                      rateController.text.isNotEmpty) {
                    provider.calculateGoldToMoney(
                      double.parse(gramsController.text),
                      double.parse(rateController.text),
                    );
                  }
                },
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate Value'),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ConverterProvider>(
              builder: (context, provider, child) {
                if (provider.goldToMoneyResult == 0) {
                  return const SizedBox.shrink();
                }
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Total Value',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        provider.goldToMoneyResult.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
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

  Widget _buildGoldItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB8860B),
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
