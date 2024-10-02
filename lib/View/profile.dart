import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('https://people.com/thmb/0mlip1OzQ_7f_B8a7SnSXj2TpwQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(749x0:751x2)/jennie-blackpink-tout-100523-710950ce95d24e068ead20ea11a3c8b2.jpg'),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', 'Asima Hasyanta', Icon(Icons.person)),
            const SizedBox(height: 10),
            itemProfile('Phone', '082283616544', Icon(Icons.phone)),
            const SizedBox(height: 10),
            itemProfile('Address', 'Babarsari City', Icon(Icons.location_city)),
            const SizedBox(height: 10),
            itemProfile('Email', 'asima@gmail.com', Icon(Icons.mail)),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Edit Profile'),
                  
              ),
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, Icon icon) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: icon,
        tileColor: Colors.white,
      ),
    );
  }
}