import 'package:flutter/material.dart';

class CompteurProvider with ChangeNotifier {
  int _compteur;

  CompteurProvider(this._compteur);

  int get counter => _compteur;

  set counter(int value) {
    _compteur = value;
  }

  void increment() {
    _compteur++;
    notifyListeners();
  }
}
