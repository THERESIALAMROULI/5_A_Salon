import 'package:flutter/material.dart';
import '/data/people.dart';

class ListNamaView extends StatelessWidget {
  const ListNamaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Daftar Nama"),
        backgroundColor: const Color.fromARGB(255, 228, 218, 128),
      ),
      body: LayoutBuilder(builder: (context, Constraints){
        if(Constraints.maxWidth > 600){
          return const WideLayout();
        }else{
          return const NarrowLayout();
        }
      }),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return PeopleList(
        onPersonTap: (person) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: PersonDetail(person),
          )
        ),),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person? _person;
  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        SizedBox(
          
          width: 300,
          
          child: Padding(
            
            padding: const EdgeInsets.all(12.0),
            child: PeopleList(
              
              onPersonTap: (person) => setState(() => _person = person),
            ),),
        ),
        Expanded(
          flex: 3,
          child: _person == null ? const Placeholder() : PersonDetail(_person!),
        ),
      ],
    );
  }
}

class PeopleList extends StatelessWidget {
  final void Function(Person) onPersonTap;
  const PeopleList({super.key, required this.onPersonTap});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for(var person in people)
      ListTile(
        tileColor: Colors.white,
 
        title: Text(person.name),
        onTap: () => onPersonTap(person)
      ),
    ]);
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;
  const PersonDetail(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext, BoxConstraints){
        return Center(
          child: BoxConstraints.maxHeight > 200 ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRczQ38KpzzA8jbdjlk6zMB5pdBDG4i-af5g&s'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                
                child: const Text("Contact Me"),
                ),
              
            ],
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             
              ElevatedButton(
                onPressed: () {},
                child: const Text("Contact Me"),
                ),
            ],
          ),
        );
      });
  }
}