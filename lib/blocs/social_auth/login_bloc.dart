import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:uba_movieapp/main.dart';
import 'package:uba_movieapp/screens/movies/movie_list.dart';


class LoginBloc {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  final BehaviorSubject<String> _facebookResult = BehaviorSubject<String>();
  // ignore: close_sinks
  final BehaviorSubject<String> _userName = BehaviorSubject<String>();

  // Streams
  Stream<String> get facebookToken => _facebookResult.stream;

  Stream<String> get userName => _userName.stream;
  // Function
  Function(String) get changeUserName => _userName.sink.add;

  signOutFacebook() async {
    await facebookSignIn.logOut();
  }

  ///Facebook SignIn
  Future<void> sigInFacebook(context) async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);
    Load.show(context);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:

        final FacebookAccessToken accessToken = result.accessToken;
        {
          final token = result.accessToken.token;
          _facebookResult.sink.add(token);
          _getUserInfo(context, token).then(changeUserName);
          break;
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        {
        _facebookResult.addError("Canceled by user");
        changeUserName('');
        break;
        }
      case FacebookLoginStatus.error:
        {
        _facebookResult.addError("Facebook auth error");
        changeUserName('');
        break;
        }
    }
  }


  ///get facebook loggedIn user details via graph.facebook.com api
  Future<String> _getUserInfo(context,String accessToken) async {
    final uri = Uri.parse("https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$accessToken");
    var graphResponse = await http.get(uri);
    final jsonResponse = json.decode(graphResponse.body);
    Load.dismiss(context);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        MovieListScreen()), (Route<dynamic> route) => false);
    // print(jsonResponse['name']);
    return jsonResponse['name'];
  }

  ///Google SignIn
  Future<User> signInWithGoogle({BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                'The account already exists with a different credential',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred using Google Sign In. Try again.',
            ),
          );
        }
      }

    return user;
  }


  // Future<void> logOut() async {
  //   try {
  //     await _auth.signOut();
  //   } catch (e) {
  //     print("error logging out");
  //   }
  // }



}


class Authentication {
  static SnackBar customSnackBar({@required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}