import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) => true);

  void submit() {
    final validEmail = _email.value;
    final validPassword = _email.value;
    print('Email is $validEmail');
    print('Password is $validPassword');
    print('Now you can sign user in!');
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}