import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/components/chip.dart';
import 'package:pokedex/constants/type_colors.dart';
import 'package:pokedex/pokeapi/crud.dart';
import 'package:pokedex/pokeapi/pokedata.dart';
import 'package:pokedex/utils.dart';

import '../utils.dart';

class PokemonPage extends StatefulWidget {
  final String id;
  PokemonPage({Key key, @required this.id}) : super(key: key);
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Response>(
          future: dio.get("https://pokeapi.co/api/v2/pokemon/${widget.id}/"),
          builder: (context, snapshot) {
            Response response = snapshot.data;
            if (response == null) {
              return Text("loading...");
            }
            final pokemon = PokemonData.fromMap(response.data);
            final mainColor = getPokemonBackgroundColor(pokemon);
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: mainColor,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(color: mainColor),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 32),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    capitalize(pokemon.name),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  children: pokemon.types.map((type) {
                                    return TypeChip(
                                        text: capitalize(type.type.name));
                                  }).toList(),
                                )
                              ],
                            )),
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 24),
                          child: Text("#${padId(pokemon.id.toString())}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 64),
                            child: Image.network(getPokemonImage(pokemon.id)))
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
