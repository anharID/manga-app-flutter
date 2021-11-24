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
    // character = fetchMangaCharacter(context);
    detail = fetchDetailManga(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: FutureBuilder<DetailManga>(
                future: detail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        width: screenSize.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          children: [
                            Image.network(snapshot.data!.imageUrl),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Score : " +
                                      snapshot.data!.score.toString()),
                                  Text("Volume : " +
                                      snapshot.data!.volume.toString()),
                                  Text("Chapter : " +
                                      snapshot.data!.chapter.toString()),
                                  Text("Rank : " +
                                      snapshot.data!.rank.toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Text(
                        "Synopsis",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Card(
                        elevation: 3,
                        color: Colors.white70,
                        margin: const EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
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
                        color: Colors.white70,
                        margin: const EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(snapshot.data!.background,
                              style: const TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.justify),
                        ),
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
                        child: const Card(
                          elevation: 3,
                          child: Text("Character"),
                        ),
                      ),
                    ]);
                  }
                  return const CircularProgressIndicator();
                })));
  }
}

class DetailManga {
  final String imageUrl;
  final String title;
  final String sinopsis;
  final String background;
  final int malId;
  final num score;
  final num volume;
  final num chapter;
  final num rank;

  // final String name;
  // final String imgUrl;
  // final int caracterId;

  DetailManga({
    required this.imageUrl,
    required this.title,
    required this.sinopsis,
    required this.background,
    required this.malId,
    required this.score,
    required this.volume,
    required this.chapter,
    required this.rank,
    // required this.name,
    // required this.imgUrl,
    // required this.caracterId,
  });
  factory DetailManga.fromJson(Map<String, dynamic> json) {
    return DetailManga(
      imageUrl: json['image_url'],
      title: json['title'],
      sinopsis: json['synopsis'],
      malId: json['mal_id'],
      score: json['score'],
      chapter: json['chapters'],
      volume: json['volumes'],
      rank: json['rank'],
      background: json['background'],
      // caracterId: json['mal_id'],
      // name: json['name'],
      // imgUrl: json['image_url'],
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
