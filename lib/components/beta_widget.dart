import 'package:flutter/material.dart';

class BetaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Greetings\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Deadline için sıralama algoritması değiştiği için daha önceki sürümde eklenmiş deadlineların silinmesinde sıkıntı çıkabilir. Uygulamanın datasını silin ya da uygulamayı silip baştan yükleyin.\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Kurslara renk özelliği geldi. Yine daha önce eklenmiş kurslarda sıkıntı çıkarsa screenshotlarla bana ulaşın, uygulamanın datasını silip tekrar deneyin. Data sıfırlanınca sorun çıkmaması lazım.\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Haftasonu yemekhaneden gelen arsız bir null anasayfayı üzüyordu. O null'ı elimine ettim. Şu an ana sayfa düzgün çalışıyor.\n",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
