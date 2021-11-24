import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tugas_akhir/components/card_view.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/screen/detailmanga.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Recommendation>> recommendation;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    recommendation = fetchRecommendation();
  }

  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rekomendasi Manga"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                child: FutureBuilder<List<Recommendation>>(
                  future: recommendation,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
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
                                        title: snapshot.data![index].title)));
                          },
                          child: CardView(
                            mangaImage: snapshot.data![index].image,
                            mangaTitle: snapshot.data![index].title,
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                      );
                    }
                    return const Text("Loading");
                  },
                ),
              ),
            )
          ],
        )));
  }
}

class Recommendation {
  Recommendation({
    //required this.rate,
    required this.title,
    required this.image,
    required this.malId,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      malId: json['mal_id'],
      title: json['title'],
      //rate: json['score'],
      image: json['image_url'],
    );
  }

  final String image;
  final int malId;
  //final num rate;
  final String title;
}

//fetch api

Future<List<Recommendation>> fetchRecommendation() async {
  final response = await http.get(
    Uri.parse('https://api.jikan.moe/v3/manga/2/recommendations'),
  );

  if (response.statusCode == 200) {
    final List airingJson = jsonDecode(response.body)['recommendations'];
    // var airingJson = jsonDecode(response.body)['top'] as List;

    return airingJson
        .map((recommmendation) => Recommendation.fromJson(recommmendation))
        .toList();

    //jika tidak di mapping hanya mendapat instance
    //intance of keynya
  } else {
    throw Exception('Failed to load airing');
  }
}
