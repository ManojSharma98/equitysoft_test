import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireStoreClass {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final liveCollection = 'Users';

  static Future<void> regUser({uid, email}) async {
    await _db.collection(liveCollection).doc(email).set({
      'email': email,
    });
  }

  static Future<void> getDetails({email}) async {
    var document = await FirebaseFirestore.instance.doc('Users/$email').get();
    var checkData = document.data;
    if (checkData == null) return;
    final prefs = await SharedPreferences.getInstance();
  }

  static Future<void> uploadImageToFireStore({image, email}) async {
    var imageurl;
    FirebaseStorage storageReference = FirebaseStorage.instance;
    Reference ref =
        storageReference.ref().child('$email/${Path.basename(image.path)}');
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask.then((res) => {imageurl = res.ref.getDownloadURL()});

    await _db.collection(liveCollection).doc(email).set({
      'email': email,
    });

  }


}
