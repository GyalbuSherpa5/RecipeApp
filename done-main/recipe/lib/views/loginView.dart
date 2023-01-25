// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:recipe/constants/routes.dart';
import 'package:recipe/utilities/showErrorDialog.dart';
import 'package:recipe/model/customTitle.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future writedata({required String email}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('name', email);
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool click = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              height: 220,
              width: 250,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                  ),
                  const Expanded(
                    child: CustomTitle(
                      text: 'FoodFolio',
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Text(
                "Discover and create delicious recipes",
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.black87,
                  letterSpacing: 2.0,
                  wordSpacing: 4.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
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
            const SizedBox(
              height: 27,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigator.pushReplacementNamed(
                  //     context, ForgetpasswordScreen.routeName);
                },
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              color: const Color.fromARGB(255, 244, 173, 66),
              textColor: Colors.white,
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  writedata(email: email);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    recipeRoute,
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    await showErrorDialog(
                      context,
                      'User not found',
                    );
                  } else if (e.code == 'wrong-password') {
                    await showErrorDialog(
                      context,
                      'Wrong password',
                    );
                  } else {
                    await showErrorDialog(
                      context,
                      'Error: ${e.code}',
                    );
                  }
                } catch (e) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              },
              child: const Text(
                'Log In',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account ? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
