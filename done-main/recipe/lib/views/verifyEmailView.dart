// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:recipe/constants/routes.dart';
import 'package:recipe/utilities/showErrorDialog.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Column(
        children: [
          const Text('Please verify your email address:'),
          TextButton(
            onPressed: () async {
              // final user = FirebaseAuth.instance.currentUser;
              // await user?.sendEmailVerification();
              await showErrorDialog(
                context,
                'Success',
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Send email verification'),
          )
        ],
      ),
    );
  }
}
