import '../../data/model/user_model.dart';

abstract class AuthRepo {
  Future<UserModel> signUp(String email, String password, String username);
  Future<void> saveUserData(UserModel user);
  Future<UserModel> signIn(String email, String password);
  Future logout();
}
