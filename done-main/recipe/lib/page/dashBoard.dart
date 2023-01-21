// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe/crud/retrive_recipe.dart';
import 'package:recipe/model/dotIndicator.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false, title: const Text('Dashboard')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              custompageView(context),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recipe')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .75,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IndividualPage(
                                      image: snapshot.data!.docs[index]
                                          ['image'],
                                      name: snapshot.data!.docs[index]['name'],
                                      time: snapshot.data!.docs[index]['time'],
                                      des: snapshot.data!.docs[index]['des'],
                                      ing: snapshot.data!.docs[index]
                                          ['ingredients'],
                                      step: snapshot.data!.docs[index]['step'],
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 170,
                                      margin: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data!.docs[index]
                                                  ['image'],
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 130,
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Text('no data found');
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Stack custompageView(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.red,
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                pageindex = value;
              });
            },
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage('assets/images/1.jpg'),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage('assets/images/2.webp'),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage('assets/images/3.jpg'),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Row(
            children: [
              ...List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Dotindicator(
                          isActive: index == pageindex,
                        ),
                      ))
            ],
          ),
        ),
      ],
    );
  }
}
