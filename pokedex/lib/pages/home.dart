import 'package:flutter/material.dart';
import 'package:pokedex/components/home_item.dart';
import 'package:pokedex/constants/colors.dart';
import 'package:pokedex/constants/labels.dart';
import 'package:pokedex/constants/page_colors.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageKeys = PageColors.keys;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 24, top: 32),
            child: Text(
              "Pokedex",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 16 / 9),
              itemCount: pageKeys.length,
              itemBuilder: (BuildContext context, int index) {
                final key = pageKeys.elementAt(index);
                final color = PageColors[key];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, key);
                    },
                    child: HomeItem(
                      text: key,
                      color: color,
                    ),
                  )
                  ,
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
