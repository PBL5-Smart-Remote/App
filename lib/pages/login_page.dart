// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:smart_home_fe/services/user_service.dart';
import 'package:smart_home_fe/utils/business/show_alert_dialog.dart';
import 'package:smart_home_fe/utils/business/show_snackbar.dart';
import 'package:smart_home_fe/utils/business/validators.dart';
import 'package:smart_home_fe/utils/widget/password_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      if (await UserService().login(username, password)) {
        Navigator.pushReplacementNamed(context, '/index');
      } else {
        showSnackBar(context, 'Error', 'Incorrect username or password', ContentType.failure);
      }
    }
  }

  Widget background() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_bg.png'),
          fit: BoxFit.fill
        )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: screenWidth / 10,
            width: 80,
            height: 200,
            child: GestureDetector(
              onDoubleTap: () => showSnackBar(context, 'From ayhoub', 'Hong Diem de thuong qua di', ContentType.help),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light_1.png')
                  )
                ),
              ),
            ),
          ),
          Positioned(
            left: 2 * screenWidth / 5,
            width: 80,
            height: 150,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/light_2.png')
                )
              ),
            ),
          ),
          Positioned(
            right: screenWidth / 10,
            top: screenHeight / 20,
            width: 80,
            height: 150,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/clock.png')
                )
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Center(
                child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginForm () {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(143, 148, 251, .2),
            blurRadius: 20.0,
            offset: Offset(0, 10)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _usernameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateEmpty,
                decoration: const InputDecoration(
                  label: Text('Username')
                ),
              ),
              PasswordFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                label: const Text('Password'),
                validator: validateEmpty,
              ),
              const SizedBox(height: 15),
              GradientElevatedButton(
                onPressed: () async => await _login(context),
                style: GradientElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, .8),
                    Color.fromRGBO(143, 148, 251, 1),
                  ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                child: const Text("Log in", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do not have an account? '),
                  GestureDetector(
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                  )
                ],
              )
            ]
          ))));
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            background(),
            loginForm(),
          ],
        ),
      ));
  }
}