import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_hd/domain/entities/user.dart';
import 'package:final_project_hd/presentation/providers/authprovider.dart';
import 'package:final_project_hd/presentation/providers/useprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Regester extends StatefulWidget {
  const Regester({super.key});

  @override
  State<Regester> createState() => _SecondState();
}

class _SecondState extends State<Regester> {
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _fullNameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -113,
            left: -81,
            child: Stack(
              children: [
                Container(
                  width: 297,
                  height: 297,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(233, 231, 116, 0.498),
                        blurRadius: 100,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 574,
            left: 133,
            child: Stack(
              children: [
                Container(
                  width: 341,
                  height: 324,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(255, 128, 94, 0.5),
                        blurRadius: 100,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 1,
            left: 45,
            child: Icon(
              Icons.save,
              size: 100,
            ),
            width: 282.13,
            height: 250.24,
          ),
          Positioned(
            top: 230.1,
            left: 55,
            child: TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 44, 44, 44))),
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 310.1,
            left: 55,
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 44, 44, 44))),
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 390.1,
            left: 55,
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 44, 44, 44))),
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 470.1,
            left: 55,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 44, 44, 44))),
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 550.1,
            left: 55,
            child: TextFormField(
              controller: repasswordController,
              decoration: InputDecoration(
                  labelText: 'Re-Password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  labelStyle:
                      TextStyle(color: const Color.fromARGB(255, 44, 44, 44))),
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 680,
            left: 125.01,
            width: 150,
            height: 35,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  final authProvider = context.read<Authprovider>();
                  final userProvider = context.read<UserProvider>();

                  final user = User(
                    fullName: fullNameController.text,
                    username: usernameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    repassword: repasswordController.text,
                  );

                  if (passwordController.text == repasswordController.text) {
                    try {
                      await context.read<Authprovider>().signUp(user);

                      await context.read<UserProvider>().add(user);

                      if (!mounted) return;

                      Navigator.of(context).pushNamed('/First');
                    } catch (e) {
                      {
                        // Handle errors
                        print('Error during sign-up: $e');
                      }
                    }
                  }

                  Navigator.of(context).pushNamed('/First');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 0, 0, 0), // Text color
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DM Sans',
                  ),
                  minimumSize: Size(150, 45), // Button size
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Button corner radius
                  ),
                ),
                child: Text('Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
