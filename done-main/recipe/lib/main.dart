import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe/constants/routes.dart';
import 'package:recipe/crud/create_recipe.dart';
import 'package:recipe/views/firebase_options.dart';
import 'package:recipe/page/bottomNav.dart';
import 'package:recipe/views/loginView.dart';
import 'package:recipe/views/registerView.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Recipe App',
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      recipeRoute: (context) => const RecipeUI(),
      createRecipeRoute: (context) => const CreateRecipe(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return const RecipeUI();
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class RecipeUI extends StatefulWidget {
  const RecipeUI({super.key});

  @override
  State<RecipeUI> createState() => _RecipeUIState();
}

class _RecipeUIState extends State<RecipeUI> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainScreen(),
    );
  }
}
