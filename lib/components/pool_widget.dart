import 'package:flutter/material.dart';
import 'package:metu_buddy/utils/common_functions.dart';

class PoolWidget extends StatefulWidget {
  final data;
  PoolWidget({this.data});
  @override
  _PoolWidgetState createState() => _PoolWidgetState();
}

class _PoolWidgetState extends State<PoolWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
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
      "Sonraki Seans: ${formattedNum(widget.data.hour)}:${formattedNum(widget.data.minute)}",
      style: TextStyle(color: Colors.white),
    );
  }
}
