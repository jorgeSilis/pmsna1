import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
