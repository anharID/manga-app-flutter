import 'package:flutter/material.dart';
import 'package:tugas_akhir/screen/home.dart';

class MangaCard extends StatelessWidget {
  final String mangaImg, mangatitle;
  const MangaCard({Key? key, required this.mangaImg, required this.mangatitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: SizedBox(
          height: 250,
          width: 130,
          child: Column(
            children: [
              Image.network(
                mangaImg,
                fit: BoxFit.cover,
              ),
              Text(
                mangatitle,
                // ignore: prefer_const_constructors
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ));
  }
}
