import 'package:flutter/material.dart';
import 'package:metu_buddy/utils/common_functions.dart';


class PoolWidget extends StatelessWidget {
  final data;
  PoolWidget({this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Text(
        "Havuz şu an genel kullanıma açık değil :|",
        style: TextStyle(color: Colors.white),
      );
    } else if (DateTime.now().weekday == DateTime.monday) {
      return Text(
        "Havuz pazartesi günleri kapalı :(",
        style: TextStyle(color: Colors.white),
      );
    }
    return Text(
      "Sonraki Seans: ${formattedNum(data.hour)}:${formattedNum(data.minute)}",
      style: TextStyle(color: Colors.white),
    );
  }
}
