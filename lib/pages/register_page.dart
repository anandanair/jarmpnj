import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jarmpnj/auth.dart';
import 'package:jarmpnj/components/my_button.dart';
import 'package:jarmpnj/components/my_textfield.dart';
import 'package:jarmpnj/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign user in method
  Future<void> createUserWithEmailAndPassword() async {
    // check if password is confirmed
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await Auth().createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        showErrorMessage(e.message ?? "");
      }
    } else {
      // Show error message, passwords dont match
      showErrorMessage("Passwords don't match");
    }
  }

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                //logo
                const Icon(
                  Icons.photo,
                  size: 50,
                ),

                const SizedBox(height: 25),

                //lets create an account for you
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),

                const SizedBox(height: 25),
                //username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: createUserWithEmailAndPassword,
                ),

                const SizedBox(height: 50),
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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
