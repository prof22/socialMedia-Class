// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/authProvider.dart';
import 'package:social_media_app/views/auth/LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username'),
              TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter your username',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none)),
                validator: (value) {
                  return value!.isEmpty ? 'Enter your username' : null;
                },
                onSaved: (value) {
                  username = value.toString();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text('Email'),
              TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter your email',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none)),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an email' : null,
                onSaved: (value) {
                  email = value.toString();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text("Password"),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter your Password here',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none)),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter password' : null,
                onSaved: (value) {
                  password = value.toString();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Consumer<Authprovider>(
                    builder: (context, authProver, child) {
                  return authProver.isLoading
                      ? const Center(
                          child: const CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState?.save();
                              await authProver
                                  .registerUser(username, email, password)
                                  .then((result) {
                                if (result == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          "Registration successful, please login to account"),
                                      duration: const Duration(
                                          seconds:
                                              5), // Duration the Snackbar is shown
                                      action: SnackBarAction(
                                        label: "Okay",
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                }
                              });
                              return;
                            }
                          },
                          child: const Text('Register'),
                        );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account with us? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
