import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EmailAuthClass {
  late UserCredential userCredential;

  final FirebaseAuth auth = FirebaseAuth.instance;
  /*
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? photo,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      userCredential.user?.updateDisplayName(name);
      userCredential.user?.updatePhotoURL(photo);
      print("Success : ${userCredential.user}");
      return true;
    } catch (e) {
      print("Error : ${userCredential.user}");
      return false;
    }
  }
  */
  Future<bool> createUserWithEmailAndPassword({
    required  String email,
    required  String password,
    required String name,
    String? photo,
  }
  ) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      print("ewe\n\n\n");
      print('User registered: ${userCredential.user}\n\n\n\n\n');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    }
  }


  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      userCredential = await auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGitHub() async {
    try {
      // Create a new provider
      GithubAuthProvider githubProvider = GithubAuthProvider();
      userCredential = await auth.signInWithProvider(githubProvider);
      return true;
    } catch (e) {
      return false;
    }
  }
}
