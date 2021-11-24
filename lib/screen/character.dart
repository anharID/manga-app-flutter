import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tugas_akhir/components/card_view.dart';

class CharacterList extends StatefulWidget {
  final int id;
  final String manga;
  const CharacterList({
    Key? key,
    required this.id,
    required this.manga,
  }) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  late Future<List<MangaCharacter>> character;

  @override
  void initState() {
    super.initState();
    character = fetchMangaCharacter(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.manga),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                child: FutureBuilder<List<MangaCharacter>>(
                  future: character,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) =>
                            //   GestureDetector(
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => MangaDetailPage(
                            //               item: snapshot.data![index].malId,
                            //               title: snapshot.data![index].title)));
                            // },

                            // ),
                            CardView(
                          mangaImage: snapshot.data![index].imgUrl,
                          mangaTitle: snapshot.data![index].name,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
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

class MangaCharacter {
  final String name;
  final String imgUrl;
  final int malId;

  MangaCharacter({
    required this.name,
    required this.imgUrl,
    required this.malId,
  });
  factory MangaCharacter.fromJson(Map<String, dynamic> json) {
    return MangaCharacter(
        malId: json['mal_id'], name: json['name'], imgUrl: json['image_url']);
  }
}

Future<List<MangaCharacter>> fetchMangaCharacter(malId) async {
  final response = await http
      .get(Uri.parse('https://api.jikan.moe/v3/manga/$malId/characters'));

  if (response.statusCode == 200) {
    final List characterJson = jsonDecode(response.body)['characters'];

    return characterJson
        .map((character) => MangaCharacter.fromJson(character))
        .toList();
  } else {
    throw Exception('Failed to load sinopsis');
  }
}
