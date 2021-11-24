import 'package:flutter/material.dart';
import 'package:tugas_akhir/components/list_card.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    const mail = "anhar2506@students.undip.ac.id";
    return Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  )),
              const Text(
                "Anhar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Teknik Komputer 2019",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.blue,
                ),
              ),
              const InfoCard(text: mail, icon: Icons.mail),
              const InfoCard(text: mail, icon: Icons.mail),
              const InfoCard(text: mail, icon: Icons.mail),
              const InfoCard(text: mail, icon: Icons.mail),
            ],
          ),
        ));
  }
}
