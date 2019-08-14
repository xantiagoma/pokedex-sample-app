import 'package:pokedex/pokeapi/crud.dart';
import 'package:pokedex/pokeapi/results.dart';

Stream<ResultPokemons> getPokemons() async* {
  var res = await getPokemonsPage();
  
}