import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_store/main.dart';
import 'package:royal_store/views/auth/presentation/controller/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: const SizedBox(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              currentUser()!.email!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                authController.signout(context);
              },
              child: const Text("logout"),
            ),
          ],
        ),
      ),
    );
  }
}
