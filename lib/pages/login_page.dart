import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../repo/auth.dart';
import '../repo/validate_email.dart';
import '../widgets/app_dialog.dart';
import '../widgets/custom_padding.dart';
import '../widgets/gradient_container.dart';
import '../widgets/liquid_button.dart';
import '../widgets/liquid_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GradientContainer(
        child: CustomPadding(
          maxWidth: 400,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: LiquidContainer(
                width: double.maxFinite,
                height: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CV Shift',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Please login to continue',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        } else if (!validateEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      obscureText: true,
                      autocorrect: false,
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    if (_isSignUp)
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }
                          if (value != _password) {
                            return 'Passwords do not match';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }

                          return null;
                        },
                        obscureText: true,
                        autocorrect: false,
                        onSaved: (value) {
                          _password = value;
                        },
                      ).animate().slideX(
                        begin: 1.0,
                        end: 0.0,
                        curve: Curves.easeInOut,
                        duration: 100.ms,
                      ),
                    const SizedBox(height: 20),

                    LiquidButton(
                      width: double.maxFinite,
                      onTap: _submit,
                      buttonText: _isSignUp ? 'Sign Up' : ' Login',
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => setState(() {
                        _isSignUp = !_isSignUp;
                      }),
                      child: Text(
                        _isSignUp
                            ? 'Already have an account? Login'
                            : 'Don\'t have an account? Sign Up',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password? Click here',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        showLoadingDialog(
          context,
          _isSignUp ? 'Signing up...' : 'Logging in...',
        );

        if (_isSignUp) {
          await AuthRepo().registerWithEmailAndPassword(_email!, _password!);
          return;
        }
        await AuthRepo().signInWithEmailAndPassword(_email!, _password!);
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop(); // Dismiss loading dialog
          showErrorDialog(
            context,
            'Login failed. Please check your credentials and try again.',
          );
        }
      }
    }
  }
}
