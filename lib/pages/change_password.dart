import 'package:flutter/material.dart';
import 'package:smart_home_fe/services/user_service.dart';
import 'package:smart_home_fe/utils/business/show_alert_dialog.dart';
import 'package:smart_home_fe/utils/widget/appbar_title.dart';
import 'package:smart_home_fe/utils/widget/password_text_form_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _cfpasswordController = TextEditingController();

  Future<void> _changePassword(BuildContext context) async {
    String newpassword = _passwordController.text;
    String cfpassword = _cfpasswordController.text;
    if (newpassword != cfpassword) {
      showAlertDialog(context, 'Passwords not match');
    } else if (await UserService().changePassword(newpassword)) {
      _passwordController.text = '';
      _cfpasswordController.text = '';
      showAlertDialog(context, "Change password successfully");
    } else {
      showAlertDialog(context, "Change password failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle('Change password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PasswordFormField(
                controller: _passwordController,
                label: Text('New password'),
              ),
              PasswordFormField(
                controller: _cfpasswordController,
                label: Text('Confirm password'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 35)
                ),
                onPressed: () async => await _changePassword(context), 
                child: const Text('Change password')
              )
            ],
          ),
        )
      ),
    );
  }
}