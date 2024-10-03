import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restaurant_bukuku/features/authentication/screens/create_pin/create_pin_screen.dart';
import 'package:restaurant_bukuku/features/authentication/screens/login/login.dart';
import 'package:restaurant_bukuku/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:restaurant_bukuku/features/authentication/screens/select_account/select_account.dart';
import 'package:restaurant_bukuku/features/navigation/screens/main_navigation/main_navigation.dart';
import 'package:restaurant_bukuku/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:restaurant_bukuku/utils/exceptions/firebase_exceptions.dart';
import 'package:restaurant_bukuku/utils/exceptions/format_exceptions.dart';
import 'package:restaurant_bukuku/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // get auth merchant
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Method to check if user has logged in within the last day
  bool isLastValidationPINWithinLastDay() {
    int? lastLoginTime = deviceStorage.read('lastValidationPIN');
    if (lastLoginTime != null) {
      DateTime lastLogin = DateTime.fromMillisecondsSinceEpoch(lastLoginTime);
      DateTime now = DateTime.now();
      return (now.difference(lastLogin).inDays < 1);
    }
    return false;
  }

  // Function to show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // if user is logged in
      if (user.emailVerified) {
        // if the user email is verified
        if (isLastValidationPINWithinLastDay() == false) {
          // session end so user must selec account again
          Get.offAll(() => const SelectAccountScreen());
        } else {
          Get.offAll(() => const MainNavigation());
        }
      } else {
        // if user email is not verified, navigate to the verify email screen
        Get.offAll(() => const CreatePIN());
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }

  // Register email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e);
      throw "Something when wrong, please try again";
    }
  }

  // Login
  Future<UserCredential?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something when wrong, please try again";
    }
  }

  // Login google
  Future<UserCredential?> loginWithGoogle() async {
    try {
      // trigger authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      // obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      // create new crededntial
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      // once signed in, return the user credential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something when wrong, please try again";
    }
  }

  // Send email verifivation
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something when wrong, please try again";
    }
  }

  // forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something when wrong, please try again";
    }
  }

  // logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      await GetStorage().remove('lastValidationPIN');
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something when wrong, please try again";
    }
  }
}
