import 'package:flutter/material.dart';
import 'package:learn/src/login_stateful/screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log me in!',
      home: Scaffold(
          body: LoginScreen(),
          appBar: AppBar(
            title: Text('Login screen'),
          )),
    );
  }
}
