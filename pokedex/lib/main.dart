import 'package:flutter/material.dart';
import 'package:pokedex/constants/labels.dart';
import 'package:pokedex/pages/home.dart';
import 'package:pokedex/pages/pokemons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color(0XF6F6F6FF)
      ),
      // home: Scaffold(body: Home(),),
      initialRoute: '/',
      routes: {
        '/': (ctx) => Home(),
        Labels.pokemons: (ctx) => Pokemons()
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: Center(
                    child: Text("Not Found: ${settings.name}"),
                  ),
                ),
              )
    );
  }
}