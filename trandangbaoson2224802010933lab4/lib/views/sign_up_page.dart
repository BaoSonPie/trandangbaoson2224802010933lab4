import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 90),
              Text(
                "Sign Up",
                style: GoogleFonts.sora(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),

              _input(email, "Email"),
              const SizedBox(height: 10),
              _input(password, "Password", obscure: true),

              const SizedBox(height: 20),

              _button("Sign Up", () {
                if (formKey.currentState!.validate()) {
                  AuthService()
                      .createAccountWithEmail(email.text, password.text)
                      .then((value) {
                        Navigator.pushReplacementNamed(context, "/login");
                      });
                }
              }),

              const SizedBox(height: 10),

              _googleButton(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/login"),
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label, {bool obscure = false}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: TextFormField(
        controller: c,
        obscureText: obscure,
        validator: (v) => v!.isEmpty ? "$label cannot be empty" : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _button(String text, VoidCallback onTap) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width * .9,
      child: ElevatedButton(onPressed: onTap, child: Text(text)),
    );
  }

  Widget _googleButton() {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width * .9,
      child: OutlinedButton(
        onPressed: () {
          AuthService().continueWithGoogle().then(
            (value) => Navigator.pushReplacementNamed(context, "/home"),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google.png", height: 25),
            const SizedBox(width: 10),
            const Text("Continue with Google"),
          ],
        ),
      ),
    );
  }
}
