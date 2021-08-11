import 'package:flutter/material.dart';
import 'package:flutter_provider_app/cours_provider.dart';
import 'package:provider/provider.dart';
import 'hexcolor.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => CoursProvider(),
        child: const MyHomePage(title: 'Provider:'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final _coursProvider = Provider.of<CoursProvider>(context);

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    // Envoyer la date dans le provider
    _coursProvider.jour = formattedDate;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${_coursProvider.quelJour} : ${_coursProvider.lesCours.length} cours prévus"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            tooltip: 'Changer de date',
            onPressed: () {
              _selectionDate(context)
                  .then((value) => _coursProvider.chargerCoursDuJour(value));
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recharger!',
            onPressed: _coursProvider.chargerCours,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _coursProvider.lesCours.length,
          itemBuilder: (context, index) {
            final Map<String, dynamic> item = _coursProvider.lesCours[index];
            final _matiereJson = item["matiere_json"] ?? 'test';
            return Card(
              child: Row(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 3,
                        color:
                            HexColor.fromHex(item["formation_color_json_v2"]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item["debut_fin_json_v2"]),
                        Text(item["formation_json_v2"]),
                        Text(item["intervenant_json"]),
                        Text(_matiereJson),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<String> _selectionDate(BuildContext context) async {
    DateTime? _dateChoisie = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030));

    if (_dateChoisie != null) {
      return _dateChoisie.toString();
    } else {
      return "";
    }
  }
}
