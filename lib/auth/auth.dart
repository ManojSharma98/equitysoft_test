import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firestoreDB.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<int> registerUser({email, pass}) async {
  var _auth = FirebaseAuth.instance;
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);

    var result = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);

    await FireStoreClass.regUser(
        uid: result.user!.uid, email: result.user!.email);

    return 1;
  } catch (e) {}
  return 1;
}

Future<void> logout() async {
  var _auth = FirebaseAuth.instance;
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  _auth.signOut();
}

Future<int> loginFirebase(String email, String pass) async {
  var _auth = FirebaseAuth.instance;
  try {
    await FireStoreClass.getDetails(email: email);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);

    var result =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    var user = result.user;
    return 1;
  } catch (e) {}
  return 0;
}
