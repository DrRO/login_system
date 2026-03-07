import 'package:authentication_flutter/screens/register_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login/cubit.dart';
import '../cubit/login/states.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Successful")),
          );

          print("Access Token: ${state.model.accessToken}");

          /// Navigate to HomeScreen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
                (route) => false,
          );
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),

                      /// Title
                      const Text(
                        "Login here",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F4ED8),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Welcome back you've\nbeen missed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// Email
                      _buildEmailField(),

                      const SizedBox(height: 20),

                      /// Password
                      _buildPasswordField(),

                      const SizedBox(height: 10),

                      /// Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot your password?",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF2F4ED8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Sign In Button
                      _buildSignInButton(state),

                      const SizedBox(height: 20),

                      /// Create Account
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Create new account",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2F4ED8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Or continue with",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialButton(Icons.g_mobiledata),
                          const SizedBox(width: 20),
                          _socialButton(Icons.facebook),
                          const SizedBox(width: 20),
                          _socialButton(Icons.apple),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Email Field
  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email is required";
        }
        if (!value.contains("@")) {
          return "Enter valid email";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Email",
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Color(0xFF2F4ED8), width: 2),
        ),
      ),
    );
  }

  /// Password Field
  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }
        if (value.length < 4) {
          return "Password must be at least 4 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          const BorderSide(color: Color(0xFF2F4ED8), width: 2),
        ),
      ),
    );
  }

  /// Sign In Button
  Widget _buildSignInButton(LoginState state) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F4ED8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: state is LoginLoading
            ? null
            : () {
          if (formKey.currentState!.validate()) {
            LoginCubit.get(context).login(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
          }
        },
        child: state is LoginLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : const Text(
          "Sign in",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Social Button
  Widget _socialButton(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon),
    );
  }
}