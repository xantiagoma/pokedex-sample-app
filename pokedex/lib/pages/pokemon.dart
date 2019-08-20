import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/components/chip.dart';
import 'package:pokedex/constants/type_colors.dart';
import 'package:pokedex/pokeapi/crud.dart';
import 'package:pokedex/pokeapi/pokedata.dart';
import 'package:pokedex/utils.dart';

class PokemonPage extends StatefulWidget {
  final String id;
  PokemonPage({Key key, @required this.id}) : super(key: key);
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
        future: dio.get("https://pokeapi.co/api/v2/pokemon/${widget.id}/"),
        builder: (context, snapshot) {
          Response response = snapshot.data;
          if (response == null) {
            return Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            );
          }
          final pokemon = PokemonData.fromMap(response.data);
          final mainColor = getPokemonBackgroundColor(pokemon);
          return Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: mainColor,
              elevation: 0,
            ),
            backgroundColor: mainColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PokemonCard(
                  pokemon: pokemon,
                ),
                new PokeInfo(pokemon: pokemon)
              ],
            ),
          );
        });
  }
}

class PokeInfo extends StatefulWidget {
  const PokeInfo({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final PokemonData pokemon;

  @override
  _PokeInfoState createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  List<String> menus = ["About", "Base Stats", "Evolution", "Moves"];
  String selected = "About";

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> tabs = {
      "About": AboutTab(
        widget: widget,
      ),
      "Base Stats": BaseStatsTab(
        widget: widget,
      ),
    };
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: menus.map((menu) {
                  final isSelected = menu == selected;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = menu;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          right: menu == menus.last ? 0 : 20, bottom: 10),
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2))),
                      child: Text(
                        menu,
                        style: isSelected
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SingleChildScrollView(
              child: tabs[selected],
            )
          ],
        ),
      ),
    );
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final PokeInfo widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FutureBuilder<String>(
            future: getPokemonDescription(id: widget.pokemon.id.toString()),
            builder: (context, snapshot) {
              String description = snapshot.data;
              if (description == null) {
                return Text("Loading...");
              }
              return Text(description.replaceAll("\n", " "));
            }),
        Container(
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              new BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: new Offset(0.0, 1.0),
                  blurRadius: 7,
                  spreadRadius: 0)
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: new DescriptionColumn(
                  widget: widget,
                  title: "Height",
                  description:
                      "${(widget.pokemon.height * 0.1).toStringAsFixed(2)}m (${metersToFeetsAndInches(widget.pokemon.height * 0.1)})",
                ),
              ),
              Expanded(
                child: new DescriptionColumn(
                  widget: widget,
                  title: "Weight",
                  description:
                      "${(widget.pokemon.weight * 0.1).toStringAsFixed(2)}kg (${kilogramsToPounds(widget.pokemon.weight * 0.1).toStringAsFixed(2)} lbs)",
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "Breeding",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Gender",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\u2642",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text("87.5%")
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "\u2640",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text("87.5%")
                    ],
                  )
                ],
              )
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Egg Groups",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ),
              Text("Monster")
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Egg Cycle",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ),
              Text("Grass")
            ]),
          ],
        )
      ],
    );
  }
}

class DescriptionColumn extends StatelessWidget {
  const DescriptionColumn({
    Key key,
    @required this.widget,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  final PokeInfo widget;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        Text(description),
      ],
    );
  }
}

class BaseStatsTab extends StatelessWidget {
  const BaseStatsTab({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final PokeInfo widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("b"),
        Text(widget.pokemon.id.toString()),
        Text("b"),
      ],
    );
  }
}

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final PokemonData pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      return TypeChip(text: capitalize(type.type.name));
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
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    height: 48,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(32),
                              topLeft: Radius.circular(32))),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  Center(child: Image.network(getPokemonImage(pokemon.id))),
                  Container()
                ],
              )),
        ],
      ),
    );
  }
}
