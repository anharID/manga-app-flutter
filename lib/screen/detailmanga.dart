import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'character.dart';

class MangaDetailPage extends StatefulWidget {
  final int item;
  final String title;
  const MangaDetailPage({
    Key? key,
    required this.item,
    required this.title,
  }) : super(key: key);

  @override
  _MangaDetailPageState createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  late Future<DetailManga> detail;

  @override
  void initState() {
    super.initState();
    detail = fetchDetailManga(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: FutureBuilder<DetailManga>(
                    future: detail,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Details",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 250,
                              width: screenSize.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Image.network(snapshot.data!.imageUrl),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(
                                  color: Colors.blue,
                                ),
                                Text(
                                  "English Title : " +
                                      snapshot.data!.englishtitle,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Japanese Title : " +
                                      snapshot.data!.japanesetitle,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Status : " + snapshot.data!.status,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Score : " + snapshot.data!.score.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Rank : " + snapshot.data!.rank.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(
                                  color: Colors.blue,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CharacterList(
                                                id: snapshot.data!.malId,
                                                manga: snapshot.data!.title)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    width: screenSize.width,
                                    child: const Card(
                                        color: Colors.blue,
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            "See Character List",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25),
                            child: Column(
                              children: [
                                const Text(
                                  "Synopsis",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  color: Colors.blue.shade100,
                                  margin: const EdgeInsets.all(20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(snapshot.data!.sinopsis,
                                        style: const TextStyle(fontSize: 16.0),
                                        textAlign: TextAlign.justify),
                                  ),
                                ),
                                const Text(
                                  "Background",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  color: Colors.blue.shade100,
                                  margin: const EdgeInsets.all(20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(snapshot.data!.background,
                                        style: const TextStyle(fontSize: 16.0),
                                        textAlign: TextAlign.justify),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]);
                      }
                      return const CircularProgressIndicator();
                    }))));
  }
}

class DetailManga {
  final String imageUrl;
  final String title;
  final String sinopsis;
  final String background;
  final String englishtitle;
  final String japanesetitle;
  final String status;
  final int malId;
  final num score;
  final num rank;

  DetailManga({
    required this.imageUrl,
    required this.title,
    required this.sinopsis,
    required this.background,
    required this.englishtitle,
    required this.japanesetitle,
    required this.status,
    required this.malId,
    required this.score,
    required this.rank,
  });
  factory DetailManga.fromJson(Map<String, dynamic> json) {
    return DetailManga(
      imageUrl: json['image_url'],
      title: json['title'],
      sinopsis: json['synopsis'],
      malId: json['mal_id'],
      score: json['score'],
      rank: json['rank'],
      background: json['background'],
      englishtitle: json['title_english'],
      japanesetitle: json['title_japanese'],
      status: json['status'],
    );
  }
}

Future<DetailManga> fetchDetailManga(malId) async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/manga/$malId'));

  if (response.statusCode == 200) {
    return DetailManga.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load sinopsis');
  }
}
