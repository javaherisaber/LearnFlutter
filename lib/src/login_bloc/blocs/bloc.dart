import 'dart:async';
import 'validators.dart';

class Bloc with Validators {
  final _email = StreamController<String>();
  final _password = StreamController<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  void dispose() {
    _email.close();
    _password.close();
  }
}