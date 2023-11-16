import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DymLoginView extends StatefulWidget {
  const DymLoginView({Key? key}) : super(key: key);

  @override
  State<DymLoginView> createState() => _DymLoginViewState();
}

class _DymLoginViewState extends State<DymLoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState()
  {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose()
  {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: Column(
                  children: [
                    TextField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email here',
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText:  true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password here',
                      ),
                    ),
                  TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                    final userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print(userCredential);
                    } on FirebaseAuthException catch (e) {
                      if(e.code == 'INVALID_LOGIN_CREDENTIALS') {
                        print('User not found or invalid login credential');
                    }
                    }
                  }, 
                  child: const Text('Login'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register', 
                            (route) => false,  
                            );
                        },
                        child: const Text('Not registered yet? Register here!'),
                      )
                    ],
                  ),
    );
  }
}