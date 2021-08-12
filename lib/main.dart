import 'package:flutter/material.dart';
import 'package:flutter_provider_app/cours_provider.dart';
import 'package:provider/provider.dart';
import 'hexcolor.dart';

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
        child: const MyHomePage(title: 'Planning'),
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.calendar_today_outlined),
              tooltip: 'Changer la date',
              onPressed: () {
                _selectionDate(context)
                    .then((value) => _coursProvider.chargerCoursDuJour(value));
              },
            ),
          ],
        ),
        body: _coursProvider.lesCours.isEmpty
            ? const Center(
                child: Text(
                  "Rien à afficher pour la date choisie...",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: _coursProvider.lesCours.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item =
                      _coursProvider.lesCours[index];
                  final _matiereJson = item["matiere_json"] ?? 'test';
                  return CoursWidget(item: item, matiereJson: _matiereJson);
                }),
      ),
    );
  }

  Future<String> _selectionDate(BuildContext context) async {
    String _result = '';

    DateTime? _dateChoisie = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030));

    if (_dateChoisie != null) {
      _result = _dateChoisie.toString().substring(0, 10);
    }
    return (_result);
  }
}

class CoursWidget extends StatelessWidget {
  const CoursWidget({
    Key? key,
    required this.item,
    required matiereJson,
  })  : _matiereJson = matiereJson,
        super(key: key);

  final Map<String, dynamic> item;
  final String _matiereJson;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 100,
                width: 3,
                color: HexColor.fromHex(item["formation_color_json_v2"]),
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
  }
}
