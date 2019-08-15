import 'package:flutter/material.dart';

class PokemonPage extends StatefulWidget {
  final String id;
  PokemonPage({Key key, @required this.id}) : super(key: key);
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                Container(
                  child: Text(widget.id + ''),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
