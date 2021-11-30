import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_waste/services/analytics_service.dart';

class AuthService  {
  static final AuthService _instance = AuthService._internal();
  final AnalyticsService _analyticsService = AnalyticsService();

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
      var userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _analyticsService.setUserProperties(userID: userCredentials.user!.uid);
      await _analyticsService.logLogin();
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> registerAccount(String email, String password) async {
    try {
      var userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _analyticsService.setUserProperties(userID: userCredentials.user!.uid);
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


