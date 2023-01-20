// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe/constants/routes.dart';
import 'package:recipe/main.dart';
import 'package:recipe/page/Individual_page.dart';
import 'package:recipe/crud/edit_recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future dataa() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var data = preferences.getString('name');
  return data!;
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String inputData() {
    final User user = auth.currentUser!;
    final uid = user.email;
    return uid!;
  }

  Future clear({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false,
                      );
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Log out'),
                  ),
                ];
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder(
                  future: dataa(),
                  builder: (context, snap) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 60,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data!.docs[index]['email'] ==
                                      snap.data.toString()) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          snapshot.data!.docs[index]['name'],
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                }),
                          );
                        } else {
                          return const Text('no data found');
                        }
                      },
                    );
                  }),
              FutureBuilder(
                  future: dataa(),
                  builder: (context, snap) {
                    return Container(
                        margin: const EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('recipe')
                              .where('email', isEqualTo: snap.data.toString())
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                IndividualPage(
                                              image: snapshot.data!.docs[index]
                                                  ['image'],
                                              name: snapshot.data!.docs[index]
                                                  ['name'],
                                              time: snapshot.data!.docs[index]
                                                  ['time'],
                                              des: snapshot.data!.docs[index]
                                                  ['des'],
                                              ing: snapshot.data!.docs[index]
                                                  ['ingredients'],
                                              step: snapshot.data!.docs[index]
                                                  ['step'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 170,
                                            margin: const EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    snapshot.data!.docs[index]
                                                        ['image'],
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['name'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                PopupMenuButton<int>(
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 1,
                                                      child: Row(
                                                        children: const [
                                                          Icon(Icons.delete),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "Delete your recipe")
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 2,
                                                      child: Row(
                                                        children: const [
                                                          Icon(Icons.edit),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "Edit your recipe")
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  offset: const Offset(0, 50),
                                                  color: Colors.white,
                                                  elevation: 2,
                                                  onSelected: (value) {
                                                    if (value == 1) {
                                                      _showDialog(
                                                        context,
                                                        title: snapshot.data!
                                                                .docs[index]
                                                            ['name'],
                                                      );
                                                    }
                                                    if (value == 2) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      EditRecipe(
                                                                        name: snapshot
                                                                            .data!
                                                                            .docs[index]['name'],
                                                                        des: snapshot
                                                                            .data!
                                                                            .docs[index]['des'],
                                                                        time: snapshot
                                                                            .data!
                                                                            .docs[index]['time'],
                                                                        step: snapshot
                                                                            .data!
                                                                            .docs[index]['step'],
                                                                        ingredients: snapshot
                                                                            .data!
                                                                            .docs[index]['ingredients'],
                                                                        image: snapshot
                                                                            .data!
                                                                            .docs[index]['image'],
                                                                      )));
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return const Text('no data found');
                            }
                          },
                        ));
                  })
            ],
          ),
        ));
  }

  _showDialog(BuildContext context, {required String title}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to delete your receipe? "),
          actions: [
            MaterialButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: const Text("yes"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('recipe')
                    .doc(title)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
