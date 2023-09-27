import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({super.key});

  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  bool _isLoggedIn = false;
  late GoogleSignInAccount userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("nnnnn")),
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  Image.network(userObj.photoUrl!),
                  Text(userObj.displayName!),
                  Text(userObj.email),
                  TextButton(
                      onPressed: () {
                        _googleSignIn.signOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                          });
                        }).catchError((e) {});
                      },
                      child: const Text("Logout"))
                ],
              )
            : Center(
                child: ElevatedButton(
                  child: const Text("Login with Google"),
                  onPressed: () {
                    _googleSignIn.signIn().then((userData) {
                      setState(() {
                        _isLoggedIn = true;
                        userObj = userData!;
                      });
                    }).catchError((e) {
                      print("33de: $e");
                    });
                  },
                ),
              ),
      ),
    );
  }
}
