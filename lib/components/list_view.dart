import 'package:flutter/material.dart';

class Listviews extends StatelessWidget {
  const Listviews({
    Key? key,
    required this.mangaImage,
    required this.mangaTitle,
    required this.score,
  }) : super(key: key);

  final String mangaImage;
  final String mangaTitle;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 2,
          child: ListTile(
            leading: Image.network(mangaImage),
            title: Text(
              mangaTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            subtitle: Text(
              "Score :" + score,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ));
  }
}

// Size screenSize = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       height: 250,
//       width: screenSize.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey.withOpacity(0.6),
//               offset: Offset(0, 10),
//               blurRadius: 10,
//               spreadRadius: -6)
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             height: 200,
//             child: Image.network(mangaImage),
//             alignment: Alignment.centerLeft,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 mangaTitle,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 3,
//                 textAlign: TextAlign.center,
//               ),
//               Text(
//                 "score : " + score,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w200,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );