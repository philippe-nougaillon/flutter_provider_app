import 'package:flutter/material.dart';
import 'package:flutter_provider_app/cours_provider.dart';
import 'package:provider/provider.dart';

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
      // home: ChangeNotifierProvider(
      //   create: (_) => CompteurProvider(100),
      //   child: const MyHomePage(title: 'Flutter Demo Home Page'),
      // ),
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

    return Scaffold(
      appBar: AppBar(
        title:
            Text("$title ${_coursProvider.lesCours.length} cours aujoud'hui"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recharger!',
            onPressed: _coursProvider.chargerCours,
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
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
