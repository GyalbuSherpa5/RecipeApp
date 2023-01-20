// ignore_for_file: unnecessary_new, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/constants/routes.dart';
import 'package:recipe/home.dart';
import 'package:recipe/page/profile.dart';

XFile? image;
String? filename;

class CreateRecipe extends StatelessWidget {
  const CreateRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              recipeRoute,
              (route) => false,
            );
          },
        ),
        title: const Text('Create Recipe'),
      ),
      body: const MyAddPage(),
    );
  }
}

class CommonThings {
  static Size? size;
}

class MyAddPage extends StatefulWidget {
  const MyAddPage({super.key});

  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController ing = TextEditingController();
  TextEditingController step = TextEditingController();
  // TextEditingController nameInputController;
  // TextEditingController imageInputController;

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Form(
            // key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // ignore: unnecessary_new

                    //image
                    new Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.blueAccent),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: image == null
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/user1.png'),
                                  )),
                            )
                          : Container(
                              color: Colors.grey,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Expanded(
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    const Divider(),
                    new IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final img =
                            await picker.pickImage(source: ImageSource.camera);
                        setState(() {
                          image = img;
                        });
                      },
                    ),
                    const Divider(),
                    new IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final img =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          image = img;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                  child: Text('Recipe Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
//name
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ' Recipe Name',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                  child: Text('Description',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                //description
                TextFormField(
                  controller: des,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                  child: Text('Cooking Time',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                //cooking time
                TextFormField(
                  controller: time,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Cooking time',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                  child: Text('Ingredients',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                //Ingredients
                TextFormField(
                  controller: ing,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ingredients',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                  child: Text('Steps',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                //Steps
                TextFormField(
                  maxLines: 4,
                  controller: step,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Steps',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FutureBuilder(
                  future: dataa(),
                  builder: (context, snap) {
                    var cc = snap.data.toString();
                    return ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Created Successfully'),
                                content: InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            child: const Text(
                                                'Created successfully'),
                                          ),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainScreen()));
                                    },
                                    child: const Text(
                                      'Done',
                                      textAlign: TextAlign.right,
                                    )),
                              );
                            });
                        FirebaseFirestore.instance
                            .collection('recipe')
                            .doc(name.text)
                            .set({
                          'name': name.text,
                          'des': des.text,
                          'email': cc,
                          'time': time.text,
                          'ingredients': ing.text,
                          'step': step.text,
                          'image': ''
                        });
                        UploadTask? uploadTask;
                        var ref = FirebaseStorage.instance
                            .ref()
                            .child('recipe')
                            .child(name.text);
                        ref.putFile(File(image!.path));
                        uploadTask = ref.putFile(File(image!.path));
                        final snap = await uploadTask.whenComplete(() {});
                        final urls = await snap.ref.getDownloadURL();
                        var user = FirebaseFirestore.instance
                            .collection('recipe')
                            .doc(name.text);
                        await user.update({'image': urls});
                      },
                      child: const Text('Create',
                          style: TextStyle(color: Colors.white)),
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }
}
