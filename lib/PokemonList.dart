import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokedex.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:pokedexapp/pokemonDetail.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decondeJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decondeJson);
    return pokedex;
  }

  int i = 1;

  _connectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _internetKontrol(
          'İnternet Hatası', "İnternete bağlanıp tekrar deneyiniz");
      i = 0;
    }
  }

  _internetKontrol(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text("Tamam"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokemon"),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return FutureBuilder(
                future: veri,
                builder: (context, AsyncSnapshot<Pokedex> gelenPokemon) {
                  _connectivity();
                  if (gelenPokemon.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokemon.connectionState ==
                          ConnectionState.done &&
                      i == 1) {
                    return GridView.count(
                      crossAxisCount: 2,
                      children: gelenPokemon.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    pokemonDetail(pokemon: poke)));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    height: 120,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/pokeball.gif",
                                      image: poke.img,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                    poke.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else
                    return Center(
                      child: Text("Hata"),
                    );
                },
              );
            } else {
              return FutureBuilder(
                future: veri,
                builder: (context, AsyncSnapshot<Pokedex> gelenPokemon) {
                  _connectivity();
                  if (gelenPokemon.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokemon.connectionState ==
                          ConnectionState.done &&
                      i == 1) {
                    return GridView.extent(
                      maxCrossAxisExtent: 300,
                      children: gelenPokemon.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    pokemonDetail(pokemon: poke)));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    height: 120,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/pokeball.gif",
                                      image: poke.img,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else
                    return Center(
                      child: Text("Hata"),
                    );
                },
              );
            }
          },
        ));
  }
}
