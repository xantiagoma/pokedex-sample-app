import 'package:flutter/material.dart';
import 'package:pokedex/constants/type_colors.dart';
import 'package:pokedex/pokeapi/crud.dart';
import 'package:pokedex/pokeapi/results.dart';
import 'package:pokedex/types/querys/get_pokemons.dart';
import 'package:pokedex/utils.dart';

class PokeCard extends StatelessWidget {
  const PokeCard({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.all(new Radius.circular(10.0));
    final t = pokemon.types
      ..sort((a, b) {
        return a.slot.compareTo(b.slot);
      });
    final types = t.map((TypeElement type) {
      return type.type;
    }).map((TypeType type) {
      return type.name;
    });
    return Container(
      decoration:
          BoxDecoration(color: getPokemonColor(pokemon), borderRadius: border),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 10, left: 10),
            alignment: Alignment.topLeft,
            child: Text(
              capitalize(pokemon.name),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 24),
            alignment: Alignment.centerRight,
            child: Image.network(getPokemonImage(pokemon.id)),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: types.map((typeName) {
                return Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    margin: EdgeInsets.only(bottom: 5, left: 5),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius:
                            BorderRadius.all(new Radius.circular(10.0))),
                    child: Text(
                      capitalize(typeName),
                      style: TextStyle(color: Colors.white),
                    ));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
