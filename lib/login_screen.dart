import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

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
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 40),

                /// Email Field
                _buildEmailField(),

                const SizedBox(height: 20),

                /// Password Field
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

                const SizedBox(height: 10),

                /// Sign In Button
                _buildSignInButton(),

                const SizedBox(height: 20),

                /// Create Account
                const Text(
                  "Create new account",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 30),

                /// Divider
                const Text(
                  "Or continue with",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),

                const SizedBox(height: 20),

                /// Social Buttons
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

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Email Field
  Widget _buildEmailField() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: "Email",
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2F4ED8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2F4ED8)),
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
    return TextField(
      controller: passwordController,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: "Password",
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
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
      ),
    );
  }

  /// Sign In Button
  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F4ED8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        onPressed: () {},
        child: const Text(
          "Sign in",
          style: TextStyle(
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
