import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/components/poke_card.dart';
import 'package:pokedex/constants/labels.dart';
import 'package:pokedex/pages/pokemon.dart';
import 'package:pokedex/types/querys/get_pokemons.dart';

class Pokemons extends StatefulWidget {
  final GraphQLClient client;
  const Pokemons({Key key, @required this.client}) : super(key: key);

  @override
  _PokemonsState createState() => _PokemonsState();
}

class _PokemonsState extends State<Pokemons> {
  List<Pokemon> pokemons = [];
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
    QueryResult res = await widget.client.query(getPage(this.pokemons.length));
    GraphResponseGetPokemons resp = GraphResponseGetPokemons.fromMap(res.data);
    List<Pokemon> pokemons = resp.pokemon;
    setState(() {
      this.pokemons.addAll(pokemons);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  QueryOptions getPage([int offset = 0, int limit = 20]) {
    String getPokemons = """
      query GetPokemons(\$limit: Int!, \$offset: Int!) {
        pokemon(limit:\$limit, offset: \$offset) {
          id,
          name,
          types {
            slot
            type {
              name
            }
          }
        }
      }
    """;
    return QueryOptions(
      document: getPokemons,
      variables: {
        'offset': offset,
        'limit': limit,
      },
      // pollInterval: 10000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        // SliverSafeArea(
        //   bottom: false,
        //   sliver: SliverToBoxAdapter(
        //     child: Container(
        //       alignment: Alignment.centerLeft,
        //       padding: EdgeInsets.only(left: 24, top: 24),
        //       child: ,
        //     ),
        //   ),
        // ),
        CupertinoSliverNavigationBar(
          largeTitle: Text("Pokemons"),
          backgroundColor: Colors.white.withOpacity(0.5),
          border: Border.all(width: 0, color: Colors.white.withAlpha(0)),
          automaticallyImplyLeading: false,
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 16, right: 16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((ctx, index) {
              if (index == pokemons.length) {
                return Text("Loading...");
              }
              final pokeResult = pokemons.elementAt(index);
              return Container(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  child: PokeCard(
                    pokemon: pokeResult,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PokemonPage(
                                  id: pokeResult.id,
                                ))

                        // MaterialPageRoute(
                        //   builder: (context) => PokemonPage(
                        //     id: pokeResult.id,
                        //   ),
                        // ),
                        );
                  },
                ),
              );
            }, childCount: pokemons.length + 1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 4 / 3),
          ),
        )

        // Expanded(
        //   child: GraphQLConsumer(
        //     builder: (GraphQLClient client) {
        //       return PokemonGridList(
        //         client: client,
        //       );
        //     },
        //   ),
        // )
      ],
    ));
  }
}
