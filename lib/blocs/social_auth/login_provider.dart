import 'package:flutter/material.dart';
import 'package:uba_movieapp/blocs/social_auth/login_bloc.dart';

//I can as well use Provider package here
class LoginProvider extends InheritedWidget {
  final LoginBloc bloc;

  LoginProvider({Key key,  Widget child})
      : bloc = LoginBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<LoginProvider>()).bloc;
  }
}
