import 'package:final_project_hd/presentation/providers/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            top: 10.1,
            left: 45,
            child: Icon(
              Icons.login,
              size: 100,
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 280.1,
            left: 55,
            child: TextFormField(
              controller: _emailController,
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
            top: 380.1,
            left: 55,
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Password',
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
            top: 500,
            left: 125.01,
            width: 150,
            height: 35,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await context.read<Authprovider>().login(
                          _emailController.text,
                          _passwordController.text,
                        );
                    Navigator.of(context).pushNamed('/Details');
                  } catch (e) {
                    print('Login failed: $e');
                  }
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
                child: Text('Login'),
              ),
            ),
          ),
          Positioned(
            top: 560.1,
            left: 88,
            child: Text(
              'If You Are Not Regisred ?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            width: 282.13,
            height: 291.24,
          ),
          Positioned(
            top: 610,
            left: 125.01,
            width: 150,
            height: 35,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/Regester');
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
