import 'package:flutter/material.dart';
import 'package:uba_movieapp/blocs/social_auth/google_button.dart';
import 'package:uba_movieapp/blocs/social_auth/login_provider.dart';
import 'package:uba_movieapp/global/custom_colors.dart';
import 'package:uba_movieapp/widgets/custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode focusNode = FocusNode();
  final _loginInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 80),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Form(
                      key: _loginInFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/firebase_logo.png',
                                height: 60,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Sign In',
                              style: TextStyle(
                                color: Palette.firebaseYellow,
                                fontSize: 20,
                              ),
                            ),

                            // CustomFormField(
                            //   controller: _uidController,
                            //   focusNode: focusNode,
                            //   keyboardType: TextInputType.text,
                            //   inputAction: TextInputAction.done,
                            //   validator: (value) => DbValidator.validateUserID(
                            //     uid: value,
                            //   ),
                            //   label: 'User ID',
                            //   hint: 'Enter your Username',
                            // ),
                            //
                            //
                            // CustomFormField(
                            //   controller: _uidController,
                            //   focusNode: focusNode,
                            //   keyboardType: TextInputType.text,
                            //   inputAction: TextInputAction.done,
                            //   validator: (value) => DbValidator.validateUserID(
                            //     uid: value,
                            //   ),
                            //   label: 'User ID',
                            //   hint: 'Enter your Password',
                            // ),

                            // Padding(
                            //   padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 10,bottom: 10),
                            //   child: Container(
                            //     width: double.maxFinite,
                            //     child: ElevatedButton(
                            //       style: ButtonStyle(
                            //         backgroundColor: MaterialStateProperty.all(
                            //           Palette.firebaseOrange,
                            //         ),
                            //         shape: MaterialStateProperty.all(
                            //           RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //           ),
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         // widget.focusNode.unfocus();
                            //
                            //       },
                            //       child: Padding(
                            //         padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                            //         child: Text(
                            //           'LOGIN',
                            //           style: TextStyle(
                            //             fontSize: 18,
                            //             fontWeight: FontWeight.bold,
                            //             color: Palette.firebaseGrey,
                            //             letterSpacing: 2,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 40,
                            ),

                            StreamBuilder(
                              stream: bloc.facebookToken,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return GestureDetector(

                                    onTap: !snapshot.hasData
                                        ? () async {
                                      print("Sign In with Facebook");
                                      bloc.sigInFacebook(context);
                                    } : null,

                                    child:

                                    Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        margin: EdgeInsets.all(24),
                                        padding: EdgeInsets.fromLTRB(
                                            24, 12, 24, 12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          color: Palette.facebookBackground,
                                        ),
                                        child: Stack(
                                          children: <Widget>[
                                            Image.asset(
                                              "assets/fb-logo.png",
                                              width: 30,
                                              color: Colors.white,
                                            ),
                                            Center(child: customText(
                                                'Sign In with Facebook',
                                                textColor: Colors.white,
                                                isCentered: true,
                                                fontFamily: fontRegular,
                                                fontSize: textSizeMedium)),
                                          ],
                                        )));
                              },
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            GoogleAuthButton(),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CustomBackButton(),
          ],
        ),
      ),
    );
  }
}
