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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                currentUser()!.email!,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                onPressed: () {
                  authController.signout(context);
                },
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
