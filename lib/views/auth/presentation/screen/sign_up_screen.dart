import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:royal_store/views/auth/presentation/controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: authProvider.signUpKey,
          child: Column(
            children: [
              TextFormField(
                controller: authProvider.usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: authProvider.emailController,
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
                controller: authProvider.passwordController,
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
                        await authProvider.signUp();
                      },
                      child: const Text('Sign Up'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
