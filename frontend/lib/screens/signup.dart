import 'package:flutter/material.dart';
import 'package:heartsync_fn/custom_fields/text_field.dart';
import 'package:heartsync_fn/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  Future<void> SignUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Supabase.instance.client.auth.signUp(
          data: {
            'display_name': nameController.text
          }, // passing display name in metadata
          email: emailController.text,
          password: passwordController.text,
        );
        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
          await Supabase.instance.client.from('profiles').insert({
            'id': user.id,
            'name': nameController.text,
          });
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Sign Up Successful")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An Unexpected Error Occurred"),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    labelText: "Name",
                    controller: nameController,
                    iconprefix: Icons.person_2,
                    iconsuffix: Icons.person_2_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
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
                    iconsuffix: Icons.lock,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text("Login"))
                  ],
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : SignUp,
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15, horizontal: 160))),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              ],
            )),
      ),
    );
  }
}
