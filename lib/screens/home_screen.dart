import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:metu_buddy/components/food_widget.dart';
import 'package:metu_buddy/components/medico_widget.dart';
import 'package:metu_buddy/components/pool_widget.dart';
import 'package:metu_buddy/components/ring_widget.dart';
import 'package:metu_buddy/models/food.dart';
import 'package:metu_buddy/models/ring.dart';
import 'package:http/http.dart'
    as html; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom;
import 'package:metu_buddy/utils/common_functions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ClosestRing> ringData;
  List<Doctor> medicoData;
  Food foodData;
  TimeOfDay poolData;
  List<dynamic> tiles = [
      {
        "name": "Yemekhane",
        "color": Colors.redAccent,
        "icon": Icons.restaurant_menu,
      },
      {
        "name": "Medico",
        "color": Colors.green,
        "icon": Icons.healing,
      },
      {
        "name": "Ring",
        "color": Colors.blueAccent[700],
        "icon": Icons.directions_bus,
      },
      {
        "name": "Havuz",
        "color": Colors.lightBlue[400],
        "icon": Icons.pool,
      },
    ];
    
  final List<TimeOfDay> sessions = [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 30),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 13, minute: 30),
    TimeOfDay(hour: 15, minute: 0),
    TimeOfDay(hour: 16, minute: 30),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 19, minute: 30),
  ];

  @override
  void initState() {
    super.initState();
    
    refreshData();
  }

  refreshData() async {
    print("refresh");
    Food food = await Food.fetchFood();
    List<Doctor> medico = await _getMedicoData();
    setState(() {
      ringData = Ring.getRingHours();
      foodData = food;
      medicoData = medico;
      poolData = closestSession();
    });
    print(poolData);
  }

  TimeOfDay closestSession() {
    var now = DateTime.now();
    print("Hello");
    for (TimeOfDay session in sessions) {
      if (totalMin(session.hour, session.minute) >=
          totalMin(now.hour, now.minute)) {
        return session;
      }
    }
    return null;
  }

  Future<List<Doctor>> _getMedicoData() async {
    var url = 'https://srm.metu.edu.tr/tr/doktor-listesi';
    var response = await html.get(url);
    var document = parse(response.body);
    List<dom.Element> list = document.querySelectorAll('td');
    List<Doctor> doctors = [];
    int i = 0;
    do {
      Doctor doctor =
          Doctor(name: list[i].text.trim(), status: list[i + 1].text.trim());
      doctors.add(doctor);
      i += 2;
    } while (i < list.length);

    return doctors;
  }

  _contentSelection(index) {
    Widget child;
    switch (index) {
      case 0:
        child = FoodWidget(data: foodData);
        break;
      case 1:
        child = MedicoWidget(data: medicoData);
        break;
      case 2:
        child = RingWidget(data: ringData);
        break;
      case 3:
        child = PoolWidget(data: poolData);
        break;
      default:
        child = null;
    }

    return child;
  }

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
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  size: 30,
                ),
                onPressed: () {
                  refreshData();
                },
              )
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
                      _contentSelection(index)
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
