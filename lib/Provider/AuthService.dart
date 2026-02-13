import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Initialize (WAJIB di versi 7)
      await _googleSignIn.initialize(
        serverClientId: "953324306666-bgl2q3f9nprthu1chk5h4fuqcuci201h.apps.googleusercontent.com"
      );
      // Authenticate user
      final GoogleSignInAccount googleUser =
      await _googleSignIn.authenticate();

      // Get ID token
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase
      final userCredential =
      await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("gagall $e");
      if (e is GoogleSignInException &&
          e.code == GoogleSignInExceptionCode.canceled) {
        return null; // jangan anggap error
      }
      rethrow;
    }
  }
}
