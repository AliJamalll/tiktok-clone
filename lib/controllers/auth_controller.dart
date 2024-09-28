import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user_model.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  //create a getter to access the file
  File? get ProfilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setIntialScreen);
  }

  _setIntialScreen(User? user){
    if(user == null){
      Get.offAll(() => LoginScreen());
    }else{
      Get.offAll(() => HomeScreen());
    }
  }

  ///pick image function
  void pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      Get.snackbar('profile Picture', 'you have successfully selected your image');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }


  ///upload to storage
  Future<String> _uploadToStorage(File image)async{
   Reference ref = firebaseStorage.ref()
       .child('profilePics')
       .child(firebaseAuth.currentUser!.uid);
   
   UploadTask uploadTask = ref.putFile(image);
   TaskSnapshot snap = await uploadTask;
   String downloadUrl = await snap.ref.getDownloadURL();
   return downloadUrl;
  }

///register the user

  void registerUser(
      String username,
      String email,
      String password,
      File? image
      )async{
    try{
      if(username.isNotEmpty&& email.isNotEmpty&& password.isNotEmpty && image != null){
     UserCredential credential =
     await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    String downloadUrl = await _uploadToStorage(image);

    model.User user = model.User(
        name: username,
        profilePhoto: downloadUrl,
        email: email,
        uid: credential.user!.uid
    );
    await firestore.collection('users').doc(credential.user!.uid).set(user.toJson());
      }else{
        Get.snackbar('error creating account', 'please enter all the fields');
      }
    }catch(e){
      Get.snackbar('error creating account', e.toString());
    }
  }

  void loginUser(String email,String password)async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){
       await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       print('log success');
      }else{
        Get.snackbar('Error Login in', 'please enter all the fields');
      }
    }catch (e){
      Get.snackbar('error login in', e.toString());
    }
  }

  void signOut()async{
    await firebaseAuth.signOut();
  }
}