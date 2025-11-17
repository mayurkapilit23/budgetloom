import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo {
  static Future<String?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return FirebaseAuth.instance.currentUser?.uid;
  }

  static Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
