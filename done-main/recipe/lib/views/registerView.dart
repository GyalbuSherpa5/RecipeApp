// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe/constants/routes.dart';
import 'package:recipe/page/bottomNav.dart';
import 'package:recipe/utilities/showErrorDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customTitle.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController name;
  bool click = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    name = TextEditingController();
    super.initState();
  }

  Future writedata({required String email}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('name', email);
  }

  FirebaseFirestore storage = FirebaseFirestore.instance;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            const Spacer(),
            const Spacer(),
            const CustomTitle(
              text: 'Sign Up',
            ),
            const Spacer(),
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: 'Enter your User name',
                labelText: 'Your User name',
                labelStyle: const TextStyle(color: Colors.white),
                fillColor: Colors.white24,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Your E-mail',
                hintText: 'Enter your email here',
                labelStyle: const TextStyle(color: Colors.white),
                fillColor: Colors.white24,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            TextField(
              controller: _password,
              obscureText: click,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Your Password',
                hintText: 'Enter your password here',
                labelStyle: const TextStyle(color: Colors.white),
                fillColor: Colors.white24,
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    click = !click;
                  }),
                  icon: click
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'By signing up you agree to our Terms of use and Piracy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
            ),
            const Spacer(),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  writedata(email: email);
                  var user = storage.collection('Users').doc(email);
                  user.set({
                    'email': email,
                    'name': name.text,
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (contexr) => const MainScreen()));
                } catch (e) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              },
              child: const Text(
                'Sign up',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    },
                    child: const Text('Login here!')),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
