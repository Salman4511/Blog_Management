
// import 'package:blog_management_app/controller/auth_controller.dart';
// import 'package:blog_management_app/utils/validators.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();
//     final _formKey = GlobalKey<FormState>();

//     void _showError(String message) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: Validators.validateEmail,
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: Validators.validatePassword,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     final email = _emailController.text;
//                     final password = _passwordController.text;

// ignore_for_file: use_build_context_synchronously

//                     try {
//                       await context
//                           .read<AuthController>()
//                           .signIn(email, password);
//                       if (context.read<AuthController>().user != null) {
//                         Navigator.pushReplacementNamed(context, '/home');
//                       } else {
//                         _showError(
//                             'Login failed. Please check your credentials.');
//                       }
//                     } catch (e) {
//                       _showError('An error occurred: $e');
//                     }
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//               Row(
//                 children: [
//                   Text("Don't have an account?"),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/signup');
//                     },
//                     child: Text('Sign Up'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:blog_management_app/controller/auth_controller.dart';
import 'package:blog_management_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    void _showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo or App Name
                const Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please log in to continue',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 20),
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 20),
                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      try {
                        await context
                            .read<AuthController>()
                            .signIn(email, password);
                        if (context.read<AuthController>().user != null) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          _showError(
                              'Login failed. Please check your credentials.');
                        }
                      } catch (e) {
                        _showError('An error occurred: $e');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
               
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
