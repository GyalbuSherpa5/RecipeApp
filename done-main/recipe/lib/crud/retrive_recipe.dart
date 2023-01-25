// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class IndividualPage extends StatelessWidget {
  String image;
  String name;
  String des;
  String time;
  String ing;
  String step;

  IndividualPage(
      {super.key,
      required this.des,
      required this.image,
      required this.ing,
      required this.name,
      required this.step,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 3000,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal,
              Colors.blue,
              Colors.teal,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(30),
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 254, 182, 73),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(image))),
                  ),
                  //name
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(18, 18, 0, 18),
                        child: Text(
                          'Recipe Name : ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 18, 10, 18),
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  //time

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(18, 0, 0, 10),
                        child: Text(
                          'Cooking time : ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 15),
                        child: Text(
                          time,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  //des
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(18, 0, 10, 10),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black, //color of divider
                          width: 10, //width space of divider
                          thickness: 3, //thickness of divier line
                          indent: 5, //Spacing at the top of divider.
                          endIndent: 13, //Spacing at the bottom of divider.
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              des,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //ingredients

                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(18, 18, 10, 10),
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black, //color of divider
                          width: 10, //width space of divider
                          thickness: 3, //thickness of divier line
                          indent: 23, //Spacing at the top of divider.
                          endIndent: 10, //Spacing at the bottom of divider.
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 18, 10, 10),
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              ing,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //step

                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 18, 10, 120),
                          child: Text(
                            'Steps',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black, //color of divider
                          width: 10, //width space of divider
                          thickness: 3, //thickness of divier line
                          indent: 23, //Spacing at the top of divider.
                          endIndent: 130, //Spacing at the bottom of divider.
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 18, 10, 130),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              step,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
