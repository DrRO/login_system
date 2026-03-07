import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import 'login_screen.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool isPasswordObscure = true;
  bool isConfirmObscure = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Account Created Successfully"),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        }

        if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F4ED8),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Create an account so you can explore all the existing jobs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 40),

                      _buildEmailField(),
                      const SizedBox(height: 20),

                      _buildPasswordField(),
                      const SizedBox(height: 20),

                      _buildConfirmPasswordField(),
                      const SizedBox(height: 30),

                      _buildSignUpButton(state),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2F4ED8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
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

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email is required";
        }
        if (!value.contains("@")) {
          return "Enter valid email";
        }
        return null;
      },
      decoration: _inputDecoration("Email", false),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: isPasswordObscure,
      validator: (value) {
        if (value == null || value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
      decoration: _inputDecoration(
        "Password",
        true,
        isPasswordObscure,
            () {
          setState(() {
            isPasswordObscure = !isPasswordObscure;
          });
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: isConfirmObscure,
      validator: (value) {
        if (value != passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      decoration: _inputDecoration(
        "Confirm Password",
        true,
        isConfirmObscure,
            () {
          setState(() {
            isConfirmObscure = !isConfirmObscure;
          });
        },
      ),
    );
  }

  Widget _buildSignUpButton(RegisterState state) {
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
        onPressed: state is RegisterLoading
            ? null
            : () {
          if (_formKey.currentState!.validate()) {
            RegisterCubit.get(context).registerUser(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
          }
        },
        child: state is RegisterLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          "Sign up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
      String hint,
      bool isPassword,
      [bool obscure = false, VoidCallback? toggle]
      ) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade200,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      suffixIcon: isPassword
          ? IconButton(
        icon: Icon(
          obscure ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: toggle,
      )
          : null,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
        const BorderSide(color: Color(0xFF2F4ED8), width: 2),
      ),
    );
  }
}