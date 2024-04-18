import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My CP Stats',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        useMaterial3: true,
      ),
      home: const MyCpStats(title: 'My Competitive Programming Statistics'),
    );
  }
}

class MyCpStats extends StatefulWidget {
  const MyCpStats({super.key, required this.title});



  final String title;

  @override
  State<MyCpStats> createState() => _MyCpStatsState();
}

class _MyCpStatsState extends State<MyCpStats> {
  late String contestName, myLearnings, contestRank, myRating, qSolved, qUpsolved;

  getContestName(name) {
    this.contestName = name;
  }
  getMyContestRank(rank) {
    this.contestRank = rank;
  }
  getMyRating(rating) {
    this.myRating = rating;
  }
  getSolvedQues(solved) {
    this.qSolved = solved;
  }
  getUpsolvedQues(upsolved) {
    this.qUpsolved = upsolved;
  }
  getMyLearnings(learnings) {
    this.myLearnings = learnings ;
  }

  createData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyContests").
    doc(contestName);
    Map<String, dynamic> contests = {
      "contestName": contestName,
      "myLearnings": myLearnings,
      "contestRank": contestRank,
      "myRating": myRating,
      "qSolved": qSolved,
      "qUpsolved": qUpsolved,
    };

    documentReference.set(contests).whenComplete( () {
      print("$contestName created");
    });
  }
  readData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyContests").
    doc(contestName);

  }
  updateData() {
    print('updated');
  }
  deleteData() {
    print('deleted');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepOrangeAccent,

        title: Text(widget.title),
      ),
      body: Column(
        children: [
    Padding(
      padding:  EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: 'Contest Name',
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepOrangeAccent,
              width: 2.0
            )
          )
        ),
        onChanged: (String name){
        getContestName(name);
      },
      ),
    ),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Rank',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepOrangeAccent,
                                width: 2.0
                            )
                        )
                    ),
                    onChanged: (rank ){
                        getMyContestRank(rank);
                        },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Rating',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrangeAccent,
                              width: 2.0,
                            )
                        )
                    ),
                    onChanged: (rating ){
                      getMyRating(rating);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Solved',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrangeAccent,
                              width: 2.0,
                            )
                        )
                    ),
                    onChanged: ( solved){
                      getSolvedQues(solved);
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Upsolved',
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrangeAccent,
                              width: 2.0,
                            )
                        )
                    ),onChanged: ( upsolved){
                    getUpsolvedQues(upsolved);
                  },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  labelText: 'Learnings',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrangeAccent,
                          width: 2.0
                      )
                  )
              ),
              onChanged: (String learnings ){
                getMyLearnings(learnings);
              },
            ),
          ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
                child: Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                  foregroundColor: Colors.white,
                ),
              onPressed: ()=>createData(),
            ),
            ElevatedButton(onPressed:() {
              readData();
            },
                child: Text('Read'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                )
            ),
            ElevatedButton(onPressed:() {
              updateData();
            },
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                )
            ),
            ElevatedButton(onPressed:() {
              deleteData();
            },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                )
            ),
          ],
        ),
      ),],
      )
      );
  }
}
