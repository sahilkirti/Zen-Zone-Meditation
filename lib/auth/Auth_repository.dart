import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static Future<bool> checkOldPassword(email, password) async {
    AuthCredential authCredential =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      var credentialResult = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(authCredential);
      return credentialResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
