import 'package:flutter/material.dart';
import 'package:metu_buddy/utils/common_functions.dart';

class FoodWidget extends StatefulWidget {
  final data;
  FoodWidget({this.data});

  @override
  _FoodWidgetState createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.wb_sunny, color: Colors.white),
                SizedBox(
                  width: 4,
                ),
                Text("Lunch",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16))
              ],
            ),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.data.lunch.length, (index) {
                  return Text(
                      capitalizeFirstLetter(widget.data.lunch[index]["name"]),
                      style: TextStyle(color: Colors.white));
                })),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.brightness_3, color: Colors.white),
                SizedBox(
                  width: 4,
                ),
                Text("Dinner",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16))
              ],
            ),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.data.dinner.length, (index) {
                  return Text(
                      capitalizeFirstLetter(widget.data.dinner[index]["name"]),
                      style: TextStyle(color: Colors.white));
                })),
          ),
        ],
      );
    } else if (DateTime.now().weekday > DateTime.friday) {
      return Center(
          child: Text("Haftasonu Yemekhane Kapalı :(",
              style: TextStyle(color: Colors.white)));
    }
    return Center(
        child: Text(
      "Datayı alamadım yav :sad:",
      style: TextStyle(color: Colors.white),
    ));
  }
}
