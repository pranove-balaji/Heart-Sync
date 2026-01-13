import 'package:flutter/material.dart';
import 'package:heartsync_fn/custom_fields/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
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
                  iconsuffix: Icons.email),
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
              onPressed: () {},
              child: Text(
                "Login",
                textAlign: TextAlign.center,
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
            TextButton(onPressed: () {}, child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}
