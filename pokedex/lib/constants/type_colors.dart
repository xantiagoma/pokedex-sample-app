import 'package:flutter/material.dart';
import 'package:pokedex/constants/colors.dart';
import 'package:pokedex/types/querys/get_pokemons.dart';
import 'package:pokedex/pokeapi/pokedata.dart' as pokedata;

final colors = {
  "grass": AppColors.green,
  "fire": AppColors.red,
  "water": AppColors.blue,
  "ground": AppColors.brown,
  "poison": AppColors.purple,
  "electric": AppColors.yellow,
  "bug": AppColors.apple_green,
  "fairy": AppColors.pink
};

Color getTypeColor(String type) {
  return colors.containsKey(type)
      ? colors[type]
      : Colors.black.withOpacity(0.4);
}

String getMainType(List<TypeElement> types) {
  final t = types
    ..sort((a, b) {
      return a.slot.compareTo(b.slot);
    });
  return t.map((TypeElement type) {
    return type.type;
  }).map((TypeType type) {
    return type.name;
  }).first;
}

String getPokemonType(List<pokedata.Type> types) {
  final t = types
    ..sort((a, b) {
      return a.slot.compareTo(b.slot);
    });
  return t.map((type) {
    return type.type;
  }).map((type) {
    return type.name;
  }).first;
}

Color getPokemonColor(Pokemon pokemon) {
  final type = getMainType(pokemon.types);
  return getTypeColor(type);
}

Color getPokemonBackgroundColor(pokedata.PokemonData pokemon) {
  final type = getPokemonType(pokemon.types);
  return getTypeColor(type);
}
