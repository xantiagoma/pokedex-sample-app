// To parse this JSON data, do
//
//     final resultPokemons = resultPokemonsFromJson(jsonString);

import 'dart:convert';

class ResultPokemons {
  int count;
  String next;
  String previous;
  List<ResultPokemon> results;

  ResultPokemons({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ResultPokemons.fromJson(String str) =>
      ResultPokemons.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultPokemons.fromMap(Map<String, dynamic> json) =>
      new ResultPokemons(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: new List<ResultPokemon>.from(
            json["results"].map((x) => ResultPokemon.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": new List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class ResultPokemon {
  String name;
  String url;

  ResultPokemon({
    this.name,
    this.url,
  });

  factory ResultPokemon.fromJson(String str) =>
      ResultPokemon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultPokemon.fromMap(Map<String, dynamic> json) => new ResultPokemon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };

  String get id => url.split("/").where((String a) => !a.isEmpty).last;
}
