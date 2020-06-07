import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:connectivity/connectivity.dart';



class pokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  pokemonDetail({this.pokemon});

  @override
  _pokemonDetailState createState() => _pokemonDetailState();
}

class _pokemonDetailState extends State<pokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRenkBul();
  }

  void baskinRenkBul(){
    Future <PaletteGenerator> fPalette=
        PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fPalette.then((value){
      paletteGenerator=value;
      debugPrint(""+paletteGenerator.dominantColor.color.toString());
      setState(() {
        baskinRenk=paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        elevation: 0,
        title: Text(""),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height * (2 / 3),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        child: Text(
                          widget.pokemon.name,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("Boy : " + widget.pokemon.height),
                      Text("Kilo : " + widget.pokemon.weight),
                      Text(
                        "Tip",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: widget.pokemon.type
                              .map((tip) => Chip(
                                  backgroundColor: baskinRenk,
                                  label: Text(
                                    tip,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )))
                              .toList()),
                      Text(
                        "Önceki Evrim",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: widget.pokemon.prevEvolution != null
                              ? widget.pokemon.prevEvolution
                                  .map((evrim) => Chip(
                                      backgroundColor: baskinRenk,
                                      label: Text(
                                        evrim.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )))
                                  .toList()
                              : [Text("İlk Hali")]),
                      Text(
                        "Sonraki Evrim",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: widget.pokemon.nextEvolution != null
                              ? widget.pokemon.nextEvolution
                                  .map((evrim) => Chip(
                                      backgroundColor: baskinRenk,
                                      label: Text(
                                        evrim.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )))
                                  .toList()
                              : [Text("Son Hali")]),
                      Text(
                        "Zayıflıklar",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: widget.pokemon.weaknesses != null
                              ? widget.pokemon.weaknesses
                                  .map((zayiflik) => Chip(
                                      backgroundColor: baskinRenk,
                                      label: Text(
                                        zayiflik,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )))
                                  .toList()
                              : Text("Zayıflığı Yok")),
                    ],
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 130,
                height: 130,
                child: Image.network(widget.pokemon.img, fit: BoxFit.fill),
              ),
            ),
          )
        ],
      ),
    );
  }
}
