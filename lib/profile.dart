import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           leading: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            
          },
        ),
          centerTitle: true,
          backgroundColor:  const Color(0XFF4C53FF),
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            TextFormField(
               enabled: false,
              initialValue: "Selvi Ayu Melinda",
              decoration: InputDecoration(
                labelText: 'First name',
                prefixIcon: Icon(
                  Iconsax.user,
                  color:  const Color(0XFF4C53FF),
                  size: 18,
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  const Color(0XFF4C53FF), width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color:  const Color(0XFF4C53FF),
                  fontSize: 15.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  const Color(0XFF4C53FF), width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
                 enabled: false,
              initialValue: "Sarumaha",
              decoration: InputDecoration(
                labelText: 'Last name',
                prefixIcon: Icon(
                  Iconsax.user,
                  color:  const Color(0XFF4C53FF),
                  size: 18,
                ),
                 disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  const Color(0XFF4C53FF), width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color:  const Color(0XFF4C53FF),
                  fontSize: 15.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  const Color(0XFF4C53FF), width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
                 enabled: false,
              initialValue: "AyuMelianda27",
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(
                  Iconsax.user,
                  color:  const Color(0XFF4C53FF),
                  size: 18,
                ),
                 disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  const Color(0XFF4C53FF), width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color:  const Color(0XFF4C53FF),
                  fontSize: 15.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:const Color(0XFF4C53FF), width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
                 enabled: false,
              initialValue: "selvi.ayu@si.ukdw.ac.id",
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: const Color(0XFF4C53FF),
                  size: 18,
                ),
                 disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0XFF4C53FF), width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color: const Color(0XFF4C53FF),
                  fontSize: 15.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0XFF4C53FF), width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
                 enabled: false,
              initialValue: "0822-7341-0312",
              decoration: InputDecoration(
                labelText: 'Phone number',
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: const Color(0XFF4C53FF),
                  size: 18,
                ),
                 disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0XFF4C53FF), width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color: const Color(0XFF4C53FF),
                  fontSize: 15.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0XFF4C53FF), width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              child: Image.asset(
                "images/photo.jpg",
                height: 200,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Text(
                  "Manage your Workspace",
                  style: TextStyle(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color =  Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  "Manage your Workspace",
                  style: TextStyle(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      
                      ..color = Color(0XFF4C53FF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ]),
        )));
  }
}
