import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/components/list_view.dart';

import 'detailmanga.dart';

class ListManga extends StatefulWidget {
  const ListManga({Key? key}) : super(key: key);

  @override
  _ListMangaState createState() => _ListMangaState();
}

class _ListMangaState extends State<ListManga> {
  late Future<List<Show>> shows;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Top List Manga"),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: FutureBuilder<List<Show>>(
                      future: shows,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MangaDetailPage(
                                            item: snapshot.data![index].malId,
                                            title:
                                                snapshot.data![index].title)));
                              },
                              child: Listviews(
                                mangaImage: snapshot.data![index].imageUrl,
                                mangaTitle: snapshot.data![index].title,
                                score: snapshot.data![index].score.toString(),
                              ),
                            ),

                            // ListTile(
                            //   leading: Image.network(
                            //       snapshot.data![index].imageUrl),
                            //   title: Text(snapshot.data![index].title),
                            //   subtitle: Text(
                            //       snapshot.data![index].score.toString()),
                            // )
                          );
                        }

                        return const CircularProgressIndicator();
                      },
                    )),
              )
            ],
          ),
        )));
  }
}

class Show {
  final int malId;
  final String title;
  final String imageUrl;
  final num score;

  Show({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/manga/1/manga'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
