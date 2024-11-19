import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_colors.dart';
import 'package:pas1_mobile_11pplg1_23/component/my_textfield.dart';
import 'package:pas1_mobile_11pplg1_23/controllers/auth_controller.dart';
import 'package:pas1_mobile_11pplg1_23/pages/login/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextfield(
                      controller: usernameController,
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.person_2_rounded),
                      onChanged: authController.updateUsername,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MyTextfield(
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock),
                      onChanged: authController.updatePassword,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter you password';
                        }
                        if (value.length < 8) {
                          return 'Password minimum 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authController.login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
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
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.to(
                            () => const RegisterPage(),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
