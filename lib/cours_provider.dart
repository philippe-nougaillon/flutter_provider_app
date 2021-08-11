import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursProvider with ChangeNotifier {
  List<dynamic> _lesCours = List<dynamic>.empty();
  final String _host = 'https://planning.iae-paris.com/';
  final String _query = 'api/v2/cours?d=';
  String _jour = '2021-09-08';

  CoursProvider();

  List<dynamic> get lesCours => _lesCours;

  String get quelJour => _jour;

  set jour(String value) {
    _jour = value;
  }

  void chargerCours() async {
    String url = _host + _query + _jour;
    final Uri uri = Uri.parse(url);

    _lesCours = json.decode(await http.read(uri));
    notifyListeners();
  }

  void chargerCoursDuJour(String jour) async {
    String url = _host + _query + jour.substring(0, 10);
    final Uri uri = Uri.parse(url);

    _lesCours = json.decode(await http.read(uri));
    notifyListeners();
  }
}
