// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:recipe/constants/routes.dart';
import 'package:recipe/utilities/showErrorDialog.dart';
import 'package:recipe/views/customTitle.dart';
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
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            const CustomTitle(
              text: 'Recipe',
            ),
            const CustomTitle(
              text: 'Log In',
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
                  style: TextStyle(color: Colors.grey),
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
              color: Colors.orange,
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
              child: const Text('Login'),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account ? ',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute,
                        (route) => false,
                      );
                    },
                    child: const Text('Not registered yet? Register'))
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
