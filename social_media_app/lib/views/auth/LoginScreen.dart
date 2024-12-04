import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/authProvider.dart';
import 'package:social_media_app/views/auth/registerScreen.dart';
import 'package:social_media_app/views/dashboard.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email'),
              TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Enter your email',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none)),
                validator: (value) =>
                    value!.isEmpty ? "Please enter email address" : null,
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
                        vertical: 15, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none)),
                validator: (value) =>
                    value!.isEmpty ? "Please enter Password" : null,
                onSaved: (value) {
                  password = value.toString();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child:
                    Consumer<Authprovider>(builder: (context, authprovider, _) {
                  return authprovider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              await authprovider
                                  .loginUser(email, password)
                                  .then((result) {
                                if (result == true) {
                                  //Navigate to a new page/screen
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashboardScreen()),
                                      (Route<dynamic> route) => false);
                                }
                              });
                            }
                          },
                          child: const Text('Login'),
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
                    const Text('Don\'t have an account with us? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                      },
                      child: const Text(
                        'Register',
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
