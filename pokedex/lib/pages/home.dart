import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: Stack(
        children: <Widget>[
          Transform.translate(
            child: Transform.scale(
              scale: 0.7,
              child: SvgPicture.asset(
                'assets/logos/pokeball.svg',
                color: Color(0x11000000),
                alignment: Alignment.topRight,
              ),
            ),
            offset: Offset(130, -200),
          ),
          SafeArea(
              child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 24, top: 100, bottom: 20),
                child: Text(
                  "What Pokemon\nare you looking for?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              InputSearch(),
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
                        onTap: () {
                          Navigator.pushNamed(context, key);
                        },
                        child: HomeItem(
                          text: key,
                          color: color,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class InputSearch extends StatefulWidget {
  InputSearch({Key key}) : super(key: key);

  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0XFFe9e9e9),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        margin: EdgeInsets.only(left: 24, right: 24, top: 10),
        child: TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
              ),
              fillColor: Color(0XFFe9e9e9),
              hintText: 'Search Pokemon, Move, Ability etc'),
          onFieldSubmitted: (str) {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            if (_formKey.currentState.validate()) {
              // Process data.
            }
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );
  }
}
