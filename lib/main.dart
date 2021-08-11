import 'package:flutter/material.dart';

import 'package:flutter_provider_app/compteur_provider.dart';
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
        child: const MyHomePage(title: 'Flutter Provider Demo Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    //final _compteurProvider = Provider.of<CompteurProvider>(context);
    final _coursProvider = Provider.of<CoursProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '$title - ${_coursProvider.lesCours.length} cours aujoud' 'hui'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nombre de cours ce jour :',
            ),
            Text(
              '${_coursProvider.lesCours.length}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _coursProvider.chargerCours,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
