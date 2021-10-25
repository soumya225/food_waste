import 'package:firebase_auth/firebase_auth.dart';

class AuthService  {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  Future<bool> emailAlreadyExists(String email) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> registerAccount(String email, String password) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}


