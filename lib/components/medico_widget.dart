import 'package:flutter/material.dart';


const List<String> categories = [
  "PRATİSYEN HEKİM",
  "DİŞ HEKİMİ",
  "FİZİK TEDAVİ",
  "KULAK BURUN BOĞAZ",
  "DERMATOLOJİ",
  "ÇOCUK HASTALIKLARI",
  "KADIN DOĞUM",
  "PSİKİYATRİ",
  "GÖĞÜS HASTALIKLARI",
  "İÇ HASTALIKLARI",
  "GÖZ HASTALIKLARI",
];

class MedicoWidget extends StatefulWidget {
  final data;
  MedicoWidget({this.data});

  @override
  _MedicoWidgetState createState() => _MedicoWidgetState();
}

class _MedicoWidgetState extends State<MedicoWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.data.length,
          (index) {
            Doctor doctor = widget.data[index];
            return Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _writeCategory(index),
                    Text(
                      "${doctor.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("${doctor.status}",
                        style: TextStyle(color: Colors.white60, fontSize: 12))
                  ],
                ));
          },
        ),
      );
    }
  }

  _writeCategory(int index) {
    String category;
    switch (index) {
      case 0:
        category = categories[0];
        break;
      case 4:
        category = categories[1];
        break;
      case 7:
        category = categories[2];
        break;
      case 8:
        category = categories[3];
        break;
      case 9:
        category = categories[4];
        break;
      case 11:
        category = categories[5];
        break;
      case 13:
        category = categories[6];
        break;
      case 15:
        category = categories[7];
        break;
      case 16:
        category = categories[8];
        break;
      case 17:
        category = categories[9];
        break;
      case 18:
        category = categories[10];
        break;
      default:
        category = "";
        break;
    }
    if(category.isEmpty){
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0,),
      child: Text(category,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, decoration: TextDecoration.underline,)),
    );
  }
}

class Doctor {
  String name;
  String status;
  Doctor({this.name, this.status});
  @override
  String toString() {
    return "$name<$status>";
  }
}
