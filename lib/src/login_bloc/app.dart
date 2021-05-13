import 'package:flutter/material.dart';
import 'package:learn/src/login_bloc/blocs/provider.dart';
import 'package:learn/src/login_bloc/screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      // todo: Don't add provider to MaterialApp in production, use it for a specific screen
      // we are using it here to demonstrate inheritedWidget concept and accessing in a child widget
      child: MaterialApp(
        title: 'Log me in',
        home: Scaffold(
          body: LoginScreen(),
          appBar: AppBar(
            title: Text('Login screen'),
          ),
        ),
      ),
    );
  }
}
