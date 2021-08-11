import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursProvider with ChangeNotifier {
  List<dynamic> _lesCours = List<dynamic>.empty();
  final Uri url =
      Uri.parse("https://planning.iae-paris.com/api/v2/cours?d=2021-09-08");

  CoursProvider();

  List<dynamic> get lesCours => _lesCours;

  void chargerCours() async {
    _lesCours = json.decode(await http.read(url));
    notifyListeners();
  }
}
