import 'package:flutter/material.dart';
import 'package:royal_store/core/routes/app_routes.dart';
import 'package:royal_store/views/auth/presentation/screen/sign_in_screen.dart';
import 'package:royal_store/views/auth/presentation/screen/sign_up_screen.dart';
import 'package:royal_store/views/main/pages/main_screen.dart';

class GenerateRoutes {
  Route generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const MainScreen();
          },
        );
      case AppRoutes.signIn:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const SignInScreen();
          },
        );
      case AppRoutes.signUp:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const SignUpScreen();
          },
        );
      default:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const SignInScreen();
          },
        );
    }
  }
}
