import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth? get _auth =>
      Firebase.apps.isNotEmpty ? FirebaseAuth.instance : null;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static const String _webClientId =
      "953324306666-bgl2q3f9nprthu1chk5h4fuqcuci201h.apps.googleusercontent.com";

  Future<User?> signInWithGoogle() async {
    try {
      if (_auth == null) {
        throw Exception("Firebase belum siap diinisialisasi.");
      }

      if (kIsWeb) {
        // Pada Web, Firebase Auth menyediakan signInWithPopup yang memunculkan pemilihan akun Google
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');
        googleProvider.setCustomParameters({
          'prompt': 'select_account',
        });

        final UserCredential userCredential =
            await _auth!.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // Pada Mobile (Android / iOS)
        await _googleSignIn.initialize(
          serverClientId: _webClientId,
        );

        final GoogleSignInAccount googleUser =
            await _googleSignIn.authenticate();

        final GoogleSignInAuthentication googleAuth =
            googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        final userCredential =
            await _auth!.signInWithCredential(credential);

        return userCredential.user;
      }
    } catch (e) {
      debugPrint("gagal login google: $e");
      if (e is GoogleSignInException &&
          e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      if (e is FirebaseAuthException &&
          (e.code == 'popup-closed-by-user' || e.code == 'cancelled')) {
        return null; // pop-up ditutup oleh user
      }
      rethrow;
    }
  }
}
