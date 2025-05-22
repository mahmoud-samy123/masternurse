
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/presentation/profile_user/model/user_model.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  static User user = auth.currentUser!;

  static Future createUser() async {
    //user.photoURL
    UserModel userModel = UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      image: user.photoURL ?? '',
      pushToken: '',
      about: "Hello I am using app",
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      online: false,
      lastActivated: DateTime.now().millisecondsSinceEpoch.toString(),
      Mobilephone: user.phoneNumber?? '',
      isDoctor: false,
    );
    await firebaseFireStore
        .collection(kUsersCollections)
        .doc(user.uid)
        .set(userModel.toJson());
  }


  // Future updateImage(){
  //
  // }
}

// kPhone:user.phoneNumber,
