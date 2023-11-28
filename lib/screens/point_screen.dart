// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tic_tac_game/constants/text_style.dart';
import 'package:tic_tac_game/screens/appbar.dart';
import '../provider/provider_info.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({super.key});

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  late final User currentUser;
  late final CollectionReference usersCollection;
  late final CollectionReference playersCollection;

  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;

  @override
  void initState() {
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    currentUser = _firebaseAuth.currentUser!;
    usersCollection = _firestore.collection('userInfo');
    playersCollection = _firestore.collection('playersInfo');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarPoint,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("pointInfo")
                .where("userId",
                    isEqualTo: Provider.of<MyProvider>(context, listen: false)
                        .checkUser())
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    Map<String, dynamic> documentSnapshot =
                        documents[index].data() as Map<String, dynamic>;

                    return SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          //margin: EdgeInsets.only(left:10, right: 10,bottom: 20),
                          color: snapshot.data.docs.length % 2 == 0
                              ? Colors.red
                              : Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      documentSnapshot["player1Name"],
                                      style: textStyle1,
                                    ),
                                    Text(
                                      documentSnapshot["player1Point"],
                                      style: textStyle12,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            print(index);
                                           FirebaseFirestore.instance.collection('pointInfo').doc(documents[index].id).delete();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 28,
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 28.0),
                                child: Column(
                                  children: [
                                    Text(
                                      documentSnapshot["player2Name"],
                                      style: textStyle1,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          documentSnapshot["player2Point"],
                                          style: textStyle12,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          documentSnapshot["dateTime"],
                                          style: textStyle11,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }

  // void deleteDocument(String documentId) async {
  //   CollectionReference collection =
  //       FirebaseFirestore.instance.collection('pointInfo');

  //    DocumentReference docRef = collection.doc(documentId);

  //   try {
  //     await docRef.delete();
  //     print('Document with ID $documentId deleted.');
  //   } catch (e) {
  //     print('Error deleting document: $e');
  //   }
  // }
}
