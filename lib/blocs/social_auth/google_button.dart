import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uba_movieapp/blocs/social_auth/login_provider.dart';
import 'package:uba_movieapp/global/custom_colors.dart';
import 'package:uba_movieapp/main.dart';
import 'package:uba_movieapp/screens/movies/movie_list.dart';
import 'package:uba_movieapp/widgets/custom_widget.dart';

class GoogleAuthButton extends StatefulWidget {
  @override
  _GoogleAuthButtonState createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ?
      Center(
        child: SpinKitFadingCircle(color: Colors.amber),
      )


          : GestureDetector(
              onTap: () async {
                setState(() {
                  _isSigningIn = true;
                });
                print("Sign In with Google");
                User user = await bloc.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MovieListScreen(
                          // user: user,
                          ),
                    ),
                  );
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(24),
                  padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Palette.googleBackground,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        "assets/google_logo.png",
                        width: 30,
                        color: Colors.white,
                      ),
                      Center(
                          child: customText('Sign In with Google',
                              textColor: Colors.white,
                              isCentered: true,
                              fontFamily: fontRegular,
                              fontSize: textSizeMedium)),
                    ],
                  ))),
    );
  }
}
