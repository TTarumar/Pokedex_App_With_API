import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokedexapp/models/pokedex.dart';
import 'package:connectivity/connectivity.dart';
import 'PokemonList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:PokemonList(),
    );
  }
}

