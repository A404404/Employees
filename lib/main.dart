
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp2());
}


class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Employees List"),
        ),
        body: StreamBuilder(

          stream: FirebaseFirestore.instance.collection("Employees").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(

              children: snapshot.data!.docs.map((document){

                Color Background_decide;

                if(document["In organisation for"] > 5) {

                  Background_decide = Colors.green;
                }else{
                  Background_decide = Colors.blue;
                }

                return ItemWidget(Name: document["Name"],Image_url: document["Image"],AWO: document["In organisation for"].toString(),age: document["Age"],Background: Background_decide,);

              }).toList(),
            );

          },
        ),
    ),);
    }
  }

class ItemWidget extends StatelessWidget {
  // final Item item;

  final String Name;
  final String Image_url;
  final String AWO;
  final String age;
  final Color Background;

  const ItemWidget({Key? key, required this.Name,required this.Image_url,required this.AWO,required this.age,required this.Background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Background,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              Image_url,
              height: 90,
              width: 90,
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(Name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))),
            ),
            subtitle: Center(child: Text("Age :- "+age, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
            trailing: Text(
              AWO,
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

