import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DymVerifyEmailView extends StatefulWidget {
  const DymVerifyEmailView({super.key});

  @override
  State<DymVerifyEmailView> createState() => _DymVerifyEmailViewState();
}

class _DymVerifyEmailViewState extends State<DymVerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
            const Text('Please verify your email address:'),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              }, 
              child: const Text('Send email verification'),
              )
          ],
        ),
    );
  }
}