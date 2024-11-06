import 'package:flutter/material.dart';
import 'package:royal_store/core/toast/toast.dart';
import 'package:royal_store/views/auth/domain/repo/auth_repo.dart';

class AuthController with ChangeNotifier {
  final AuthRepo _authRepo;

  AuthController(this._authRepo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final signUpKey = GlobalKey<FormState>();
  final TextEditingController emailController2 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final signInKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    if (signUpKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();
      try {
        await _authRepo.signUp(
          emailController.text.trim(),
          passwordController.text.trim(),
          usernameController.text.trim(),
        );
      } catch (e) {
        MyToast.show("Sign-up failed: $e");
        rethrow;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> signIn() async {
    if (signInKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();

      try {
        await _authRepo.signIn(
          emailController2.text.trim(),
          passwordController2.text.trim(),
        );
      } catch (e) {
        MyToast.show("Sign-in failed: $e");
        rethrow;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}