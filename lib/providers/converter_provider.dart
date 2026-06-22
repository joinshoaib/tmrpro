import 'package:flutter/material.dart';
import '../utils/conversions.dart';

class ConverterProvider extends ChangeNotifier {
  // Conversion state
  double _grams = 0;
  int _tola = 0;
  int _masha = 0;
  double _ratti = 0;

  // Rate calculator state
  double _amount = 0;
  double _ratePerTola = 0; // Changed from _ratePerGram

  // Results
  Map<String, dynamic> _tmrResult = {};
  double _gramsResult = 0;
  Map<String, dynamic> _moneyToGoldResult = {};
  double _goldToMoneyResult = 0;

  // Getters
  double get grams => _grams;
  int get tola => _tola;
  int get masha => _masha;
  double get ratti => _ratti;
  double get amount => _amount;
  double get ratePerTola => _ratePerTola; // Updated getter
  Map<String, dynamic> get tmrResult => _tmrResult;
  double get gramsResult => _gramsResult;
  Map<String, dynamic> get moneyToGoldResult => _moneyToGoldResult;
  double get goldToMoneyResult => _goldToMoneyResult;

  // Grams to TMR conversion
  void convertGramsToTMR(double grams) {
    _grams = grams;
    _tmrResult = GoldConversions.gramsToTMR(grams);
    notifyListeners();
  }

  // TMR to Grams conversion
  void convertTMRToGrams(int tola, int masha, double ratti) {
    _tola = tola;
    _masha = masha;
    _ratti = ratti;
    _gramsResult = GoldConversions.tmrToGrams(tola, masha, ratti);
    notifyListeners();
  }

  // Money to Gold (rate per TOLA)
  void calculateMoneyToGold(double amount, double ratePerTola) {
    _amount = amount;
    _ratePerTola = ratePerTola;
    _moneyToGoldResult = GoldConversions.moneyToGold(amount, ratePerTola);
    notifyListeners();
  }

  // Gold to Money (rate per TOLA)
  void calculateGoldToMoney(double grams, double ratePerTola) {
    _ratePerTola = ratePerTola;
    _goldToMoneyResult = GoldConversions.goldToMoney(grams, ratePerTola);
    notifyListeners();
  }
}
