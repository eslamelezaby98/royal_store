import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_store/core/routes/app_routes.dart';
import 'package:royal_store/views/auth/presentation/controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: authProvider.signUpKey,
          child: Column(
            children: [
              TextFormField(
                controller: authProvider.emailController2,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: authProvider.passwordController2,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        await authProvider.signIn(context);
                      },
                      child: const Text('Sign In'),
                    ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.signUp);
                },
                child: const Text("Do't have an account? Sign Up now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
