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
    const nim = "21120119120012";
    const school = "Universitas Diponegoro";
    const address = "Semarang";
    return Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  )),
              const Text(
                "Anhar",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
              const InfoCard(text: nim, icon: Icons.perm_identity),
              const InfoCard(text: mail, icon: Icons.mail),
              const InfoCard(text: school, icon: Icons.school),
              const InfoCard(text: address, icon: Icons.maps_home_work),
            ],
          ),
        )));
  }
}
