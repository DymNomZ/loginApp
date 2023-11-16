import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testapp/firebase_options.dart';
import 'package:testapp/views/dym_login_view.dart';
import 'package:testapp/views/dym_register_view.dart';
import 'package:testapp/views/dym_verify_email_view.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DymHomePage(),
      routes: {
        '/login' : (context) => const DymLoginView(),
        '/register' : (context) => const DymRegisterView(),
      },
    ),
  );
}

class DymHomePage extends StatelessWidget {
  const DymHomePage({super.key});

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
            ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null){
              if(user.emailVerified){
                print('Email is verified');
              } else {
                return const DymVerifyEmailView();
              }
            } else {
              return const DymLoginView();
            }
            return const Text('Done');
          default: 
            return const CircularProgressIndicator();
          }
        },
      );
  }
}