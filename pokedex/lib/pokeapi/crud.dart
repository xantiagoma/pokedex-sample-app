import 'package:dio/dio.dart';
import 'package:pokedex/pokeapi/pokeapi.dart';
import 'package:pokedex/utils.dart';

const BASE_URL = "https://pokeapi.co/api/v2/pokemon";
final dio = Dio();

Future<ResultPokemons> getPokemonsPage(
    {final url, final int offset = 0, final int limit = 10}) async {
  final request_url = url ?? "$BASE_URL/?limit=$limit&offset=$offset";
  final response = await dio.get(request_url);
  final data = ResultPokemons.fromMap(response.data);
  return data;
}

String getPokemonImage(dynamic id, {full: false}) {
  final pokemonId = padId(id.toString());
  return 'https://assets.pokemon.com/assets/cms2/img/pokedex/${full ? 'full' : 'detail'}/$pokemonId.png';
}
