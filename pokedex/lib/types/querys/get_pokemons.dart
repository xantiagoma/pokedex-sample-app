import 'dart:convert';

class GraphResponseGetPokemons {
    List<Pokemon> pokemon;

    GraphResponseGetPokemons({
        this.pokemon,
    });

    factory GraphResponseGetPokemons.fromJson(String str) => GraphResponseGetPokemons.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GraphResponseGetPokemons.fromMap(Map<String, dynamic> json) => new GraphResponseGetPokemons(
        pokemon: new List<Pokemon>.from(json["pokemon"].map((x) => Pokemon.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "pokemon": new List<dynamic>.from(pokemon.map((x) => x.toMap())),
    };
}

class Pokemon {
    String id;
    String name;
    List<TypeElement> types;

    Pokemon({
        this.id,
        this.name,
        this.types,
    });

    factory Pokemon.fromJson(String str) => Pokemon.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pokemon.fromMap(Map<String, dynamic> json) => new Pokemon(
        id: json["id"],
        name: json["name"],
        types: new List<TypeElement>.from(json["types"].map((x) => TypeElement.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "types": new List<dynamic>.from(types.map((x) => x.toMap())),
    };
}

class TypeElement {
    int slot;
    TypeType type;

    TypeElement({
        this.slot,
        this.type,
    });

    factory TypeElement.fromJson(String str) => TypeElement.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TypeElement.fromMap(Map<String, dynamic> json) => new TypeElement(
        slot: json["slot"],
        type: TypeType.fromMap(json["type"]),
    );

    Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type.toMap(),
    };
}

class TypeType {
    String name;

    TypeType({
        this.name,
    });

    factory TypeType.fromJson(String str) => TypeType.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TypeType.fromMap(Map<String, dynamic> json) => new TypeType(
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
    };
}
