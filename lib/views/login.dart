import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final AuthController authController = Get.put(AuthController()); // Initialize AuthController
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              // This will show the loading spinner when isLoading is true
              return authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        // Trigger the login method from the AuthController
                        authController.loginUser(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                      child: Text('Login'),
                    );
            }),
            SizedBox(height: 20),
            Obx(() {
              // Display error message if there is one
              return Text(
                authController.errorMessage.value,
                style: TextStyle(color: Colors.red),
              );
            }),
          ],
        ),
      ),
    );
  }
}
