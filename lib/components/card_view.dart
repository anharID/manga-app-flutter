import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    required this.mangaTitle,
    required this.mangaImage,
    //required this.score,
  }) : super(key: key);

  final String mangaTitle;
  final String mangaImage;
  //final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: Offset(0, 10),
                blurRadius: 10,
                spreadRadius: -6)
          ],
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.30), BlendMode.multiply),
            image: NetworkImage(mangaImage),
            fit: BoxFit.cover,
          )),
      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                mangaTitle,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Align(
          //   child: Container(
          //     padding: const EdgeInsets.all(5),
          //     margin: const EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //         color: Colors.white.withOpacity(0.5),
          //         borderRadius: BorderRadius.circular(15)),
          //     child: Row(
          //       children: [
          //         const Icon(
          //           Icons.star,
          //           color: Colors.amber,
          //           size: 18,
          //         ),
          //         const SizedBox(
          //           width: 8,
          //         ),
          //         Text(score)
          //       ],
          //     ),
          //   ),
          //   alignment: Alignment.bottomCenter,
          // ),
        ],
      ),
    );
  }
}
