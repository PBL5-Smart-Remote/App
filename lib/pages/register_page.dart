// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';import 'package:smart_home_fe/services/user_service.dart';
import 'package:smart_home_fe/utils/business/date_picker.dart';
import 'package:smart_home_fe/utils/business/show_alert_dialog.dart';
import 'package:smart_home_fe/utils/business/validators.dart';
import 'package:intl/intl.dart';
import 'package:smart_home_fe/utils/widget/password_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cfpasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await selectDate(context);
    if (selectedDate != null) {
      _dobController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
  }

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String fullname = _fullnameController.text;
      String username = _usernameController.text;
      String email = _emailController.text;
      String dob = _dobController.text;
      String phonenumber = _phonenumberController.text;
      String password = _passwordController.text;
      String cfpassword = _cfpasswordController.text;
      if (password != cfpassword) {
        showAlertDialog(context, "Password not match");
      }  else if (await UserService().register(fullname, username, password, email, dob, phonenumber)) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        showAlertDialog(context, "Invalid information");
      }
    }
  }

  Widget background() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.4,
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
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/light_1.png')
                )
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
              margin: const EdgeInsets.only(top: 100),
              child: const Center(
                child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget registeForm() {
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _fullnameController,
                validator: validateEmpty,
                decoration: const InputDecoration(
                  label: Text('Full name')
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _usernameController,
                validator: validateEmpty,
                decoration: const InputDecoration(
                  label: Text('Username')
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                validator: validateEmail,
                decoration: const InputDecoration(
                  label: Text('Email')
                ),
              ),
              TextFormField(
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _dobController,
                validator: validateEmpty,
                decoration: const InputDecoration(
                  label: Text('Date of birth'),
                  suffixIcon: Icon(
                    // onPressed: () async => await _selectDate(context),
                    Icons.date_range,
                  )
                ),
                onTap: () async => await _selectDate(context)
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _phonenumberController,
                validator: validateEmpty,
                decoration: const InputDecoration(
                  label: Text('Phone number')
                ),
              ),
              PasswordFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                validator: validateEmpty,
                label: const Text("Password"),
              ),
              PasswordFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _cfpasswordController,
                validator: validateEmpty,
                label: const Text("Confirm password"),
              ),
              const SizedBox(height: 15),
              GradientElevatedButton(
                onPressed: () async => await _register(context),
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
                child: const Text("Register", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      Navigator.pushReplacementNamed(context, '/login');
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
            registeForm(),
          ],
        ),
      ));
  }
}