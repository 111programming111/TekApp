import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tek_app/core/view_model/control_view_model.dart';
import 'package:tek_app/helper/local_storage_data.dart';
import 'package:tek_app/model/user_model.dart';
import 'package:tek_app/view/control_view.dart';
import 'package:tek_app/view/home_view.dart';
import '../services/firestore_user.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();

  String email = '';
  String password = '';
  String name = '';

  Rxn<User> _user = Rxn<User>();
  get user => _user.value?.email;
  final LocalStorageData localStorageData = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getCurrentUserData(_auth.currentUser!.uid);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    print(googleUser);

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    await _auth.signInWithCredential(credential).then((user) async {
      saveUser(user);
    });
    Get.offAll(Control_View());
  }

  void facebookSignInMethod() async {
    // print('fsdfkjdshf--------------->');
    final FacebookLoginResult result = await _facebookLogin.logIn(
        customPermissions: (["email", 'public_profile']));
    final accessToken = result.accessToken?.token;
    if (result.status == FacebookLoginStatus.success) {
      final faceCredential = FacebookAuthProvider.credential(accessToken!);
      await _auth.signInWithCredential(faceCredential).then((user) async {
        saveUser(user);
      });
      ;
      Get.offAll(HomeView());
    }
  }

  void sinnInWithEmailAndPassword() async {
    Map<String, dynamic> returnMap = new Map();
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
          getCurrentUserData(value.user!.uid);
      });

      Get.offAll(Control_View());
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error Login account", e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.TOP);
    }
  }

  void createAccountWiEmailAndPassword() async {
    try {
      final us = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((user) async {
        saveUser(user);
      });

      Get.offAll(Control_View());
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error Login account", e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.TOP);
    }
  }

  // save user in firebase
  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
        name: name == null ? user.user?.displayName : name,
        pic: '',
        userId: user.user?.uid,
        email: user.user?.email);
    await FirestoreUser().addUserToFirestore(userModel);
    setUser(userModel);
  }

  void getCurrentUserData(String uid) async {
    Map<String, dynamic> returnMap = new Map();
    await FirestoreUser().getCurrentUser(uid).then((value) {
      returnMap['userId'] = value['userId'];
      returnMap['email'] = value['email'];
      returnMap['name'] = value['name'];
      returnMap['pic'] = value['pic'];
      setUser(UserModel.fromJson(returnMap));
    });
  }

  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
  }
}
