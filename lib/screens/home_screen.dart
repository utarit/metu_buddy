import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:metu_buddy/components/food_widget.dart';
import 'package:metu_buddy/components/medico_widget.dart';
import 'package:metu_buddy/components/pool_widget.dart';
import 'package:metu_buddy/components/ring_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<dynamic> tiles = [
    {
      "name": "Yemekhane",
      "color": Colors.redAccent,
      "icon": Icons.restaurant_menu,
      "content": FoodWidget()
    },
    {
      "name": "Ring",
      "color": Colors.blueAccent[700],
      "icon": Icons.directions_bus,
      "content": RingWidget()
    },
    {
      "name": "Havuz",
      "color": Colors.lightBlue[400],
      "icon": Icons.pool,
      "content": PoolWidget()
    },
    {
      "name": "Medico",
      "color": Colors.green,
      "icon": Icons.healing,
      "content": MedicoWidget()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Merhaba Hocam!",
                style: TextStyle(
                    fontFamily: "Galano",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              // IconButton(
              //   icon: Icon(Icons.category),
              //   onPressed: () => null,
              // )
            ],
          ),
        ),
        Expanded(
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            padding: EdgeInsets.all(8.0),
            itemCount: 4,
            shrinkWrap: true,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: tiles[index]["color"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(
                          tiles[index]["icon"],
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        tiles[index]["name"],
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      tiles[index]["content"]
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
