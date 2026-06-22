class GoldConversions {
  // Standard conversions (1 Tola = 11.664 grams)
  static const double gramsPerTola = 11.664;
  static const double mashaPerTola = 12;
  static const double rattiPerMasha = 8;
  static const double rattiPerTola = 96; // 12 * 8

  // Grams to Tola-Masha-Ratti
  static Map<String, dynamic> gramsToTMR(double grams) {
    double totalRatti = grams / (gramsPerTola / rattiPerTola);
    int tola = totalRatti ~/ rattiPerTola;
    double remainingRatti = totalRatti % rattiPerTola;
    int masha = remainingRatti ~/ rattiPerMasha;
    double ratti = remainingRatti % rattiPerMasha;

    return {'tola': tola, 'masha': masha, 'ratti': ratti.toStringAsFixed(2)};
  }

  // Tola-Masha-Ratti to Grams
  static double tmrToGrams(int tola, int masha, double ratti) {
    double totalRatti = (tola * rattiPerTola) + (masha * rattiPerMasha) + ratti;
    return (totalRatti * gramsPerTola) / rattiPerTola;
  }

  // Rate Calculator: Money to Gold
  static Map<String, dynamic> moneyToGold(double amount, double ratePerGram) {
    double grams = amount / ratePerGram;
    return {'grams': grams.toStringAsFixed(3), 'tmr': gramsToTMR(grams)};
  }

  // Rate Calculator: Gold to Money
  static double goldToMoney(double grams, double ratePerGram) {
    return grams * ratePerGram;
  }
}
