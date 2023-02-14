import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jarmpnj/services/auth.dart';
import 'package:jarmpnj/components/my_button.dart';
import 'package:jarmpnj/components/my_textfield.dart';
import 'package:jarmpnj/components/square_tile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign user in method
  Future<void> signInWithEmailAndPassword() async {
    showLoading();
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.message ?? "");
    }
  }

// Show loading to user
  void showLoading() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white, size: 100));
      },
      barrierDismissible: false,
    );
  }

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade200,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                //logo
                const Icon(
                  Icons.photo,
                  size: 100,
                ),

                const SizedBox(height: 30),

                //welcome back
                Text(
                  'Welcome back you\'ve been missed!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 25),
                //username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 10),

                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  text: 'Sign In',
                  onTap: signInWithEmailAndPassword,
                ),

                const SizedBox(height: 50),
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
                //google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                      imagePath: 'lib/images/google.png',
                      onTap: () => Auth().signInWithGoogle(),
                    ),

                    const SizedBox(width: 25),

                    //apple button
                    SquareTile(
                      imagePath: 'lib/images/apple.png',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.blue,
                                ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
