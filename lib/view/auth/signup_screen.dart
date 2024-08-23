
// import 'package:blog_management_app/controller/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SignupScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();
//     final _confirmPasswordController = TextEditingController();

//     void showError(String message) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: _confirmPasswordController,
//               decoration: InputDecoration(labelText: 'Confirm Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final email = _emailController.text;
//                 final password = _passwordController.text;
//                 final confirmPassword = _confirmPasswordController.text;

//                 if (password != confirmPassword) {
//                   showError('Passwords do not match.');
//                   return;
//                 }

//                 try {
//                   await context.read<AuthController>().signUp(email, password);
//                   if (context.read<AuthController>().user != null) {
//                     Navigator.pushReplacementNamed(context, '/home');
//                   } else {
//                     showError('Signup failed. Please try again.');
//                   }
//                 } catch (e) {
//                   showError('An error occurred: $e');
//                 }
//               },
//               child: Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:blog_management_app/controller/auth_controller.dart';
import 'package:blog_management_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    void _showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) => Validators.validateConfirmPassword(
                    value, _passwordController.text),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    try {
                      await context
                          .read<AuthController>()
                          .signUp(email, password);
                      if (context.read<AuthController>().user != null) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        _showError('Signup failed. Please try again.');
                      }
                    } catch (e) {
                      _showError('An error occurred: $e');
                    }
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
