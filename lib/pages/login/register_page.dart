import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_colors.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_textfield.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextfield(
                    controller: usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    obscureText: false,
                    prefixIcon: Icon(Icons.person_2_outlined),
                    onChanged: authController.updateUsername,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextfield(
                    controller: fullNameController,
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.badge_outlined),
                    onChanged: authController.updateFullName,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Full name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextfield(
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    obscureText: false,
                    prefixIcon: Icon(Icons.email_outlined),
                    onChanged: authController.updateEmail,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextfield(
                    controller: passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                    onChanged: authController.updatePassword,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authController.register();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Obx(
                        () => authController.isLoading.value
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: Lottie.asset(
                                  'lib/assets/animation_mini_loading.json',
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
