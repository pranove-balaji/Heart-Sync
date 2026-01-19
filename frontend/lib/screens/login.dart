import 'package:flutter/material.dart';
import 'package:heartsync_fn/custom_fields/text_field.dart';
import 'package:heartsync_fn/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:heartsync_fn/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await Supabase.instance.client.auth.signInWithPassword(
          email: emailController.text, password: passwordController.text);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login successful")));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("An unexpected error occurred"),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(" Welcome Back",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(" to your account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  labelText: "Email",
                  controller: emailController,
                  iconprefix: Icons.person,
                  iconsuffix: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains("@")) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                    labelText: "Password",
                    controller: passwordController,
                    iconprefix: Icons.no_encryption,
                    iconsuffix: Icons.lock),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  isLoading ? null : login();
                },
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                style: ButtonStyle(
                    backgroundColor: (MaterialStatePropertyAll(Colors.black)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 15, horizontal: 160))),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Text("Don't Have Account?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
