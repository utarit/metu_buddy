import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as html; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom;

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
  @override
  _MedicoWidgetState createState() => _MedicoWidgetState();
}

class _MedicoWidgetState extends State<MedicoWidget> {
  List<Doctor> doctorList;

  _getMedicoData() async {
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

    setState(() {
      doctorList = doctors;
    });
  }

  @override
  void initState() {
    super.initState();
    _getMedicoData();
  }

  @override
  Widget build(BuildContext context) {
    if (doctorList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          doctorList.length,
          (index) {
            Doctor doctor = doctorList[index];
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
