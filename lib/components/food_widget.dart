import 'package:flutter/material.dart';
import 'package:metu_helper/models/food.dart';

class FoodWidget extends StatefulWidget {

  @override
  _FoodWidgetState createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  Future<Food> food;


   String capitalizeFirstLetter(String str) {
     var arr = str.split(" ");
     var result = [];
     for(String s in arr){
       result.add((s?.isNotEmpty ?? false) ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}' : s);
     }
     return result.join(" ");
   }
  

  @override
  void initState() {
    super.initState();
    food = Food.fetchFood();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Food>(
      future: food,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.wb_sunny, color: Colors.white),
                    SizedBox(width: 4,),
                    Text("Lunch", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16))
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(snapshot.data.lunch.length, (index){
                    return Text(capitalizeFirstLetter(snapshot.data.lunch[index]["name"]), style: TextStyle(color: Colors.white));
                  })
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.brightness_3, color: Colors.white),
                    SizedBox(width: 4,),
                    Text("Dinner", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16))
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(snapshot.data.dinner.length, (index){
                    return Text(capitalizeFirstLetter(snapshot.data.dinner[index]["name"]), style: TextStyle(color: Colors.white));
                  })
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          if(DateTime.now().weekday > 6){
            return Center(child: Text("Haftasonu Yemekhane Kapalı :(", style: TextStyle(color: Colors.white)));
          }
          return Center(child: Text("Datayı alamadım yav :sad:", style: TextStyle(color: Colors.white),));
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}