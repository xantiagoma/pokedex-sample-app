import 'package:flutter/material.dart';
import 'package:pokedex/constants/labels.dart';
import 'package:pokedex/constants/page_colors.dart';
import 'package:pokedex/pokeapi/crud.dart';
import 'package:pokedex/pokeapi/results.dart';

class Pokemons extends StatelessWidget {
  const Pokemons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 32, top: 32),
            child: Text(
              Labels.pokemons,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: PageColors[Labels.pokemons]),
            ),
          ),
          Expanded(child: PokemonGridList(),)
        ],
      )),
    );
  }
}

class PokemonGridList extends StatefulWidget {
  PokemonGridList({Key key}) : super(key: key);
  _PokemonGridListState createState() => _PokemonGridListState();
}

class _PokemonGridListState extends State<PokemonGridList> {

  List<ResultPokemon> pokemons = [];
  String next;
  bool loadMore = true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    this.fetch();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.fetch();
      }
    });
  }

  fetch() async {
    if(!loadMore) {
      return;
    }
    var result = await getPokemonsPage(url: next, limit: 20);
    setState(() {
      pokemons.addAll(result.results);
      next = result.next;
      loadMore = result.next != null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(left: 32, right: 32),
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:  2,
        childAspectRatio: 3/4
      ),
      itemBuilder: (BuildContext context, int index) {
        if(index == pokemons.length) {
          return Text("Loading...");
        }
        final pokeResult = pokemons.elementAt(index);
        return Column(
          children: <Widget>[
            Image.network(getPokemonImage(pokeResult.id)),
            Text(pokeResult.name),
          ],
        );
      },
      itemCount: pokemons.length + 1,
    );
  }
}