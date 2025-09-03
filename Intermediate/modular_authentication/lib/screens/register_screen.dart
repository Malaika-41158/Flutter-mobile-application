import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';
import '../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Create Account",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    InputField(
                      controller: _fullNameCtrl,
                      label: "Full Name",
                      validator: Validators.requiredField,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    InputField(
                      controller: _emailCtrl,
                      label: "Email",
                      validator: Validators.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    InputField(
                      controller: _passwordCtrl,
                      label: "Password",
                      obscureText: _obscurePassword,
                      validator: Validators.password,
                      textInputAction: TextInputAction.next,
                      onToggleVisibility: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    const SizedBox(height: 16),

                    InputField(
                      controller: _confirmCtrl,
                      label: "Confirm Password",
                      obscureText: _obscureConfirm,
                      validator: (v) =>
                          Validators.confirmPassword(v, _passwordCtrl.text),
                      onToggleVisibility: () {
                        setState(() => _obscureConfirm = !_obscureConfirm);
                      },
                    ),
                    const SizedBox(height: 20),

                    if (auth.error != null)
                      Text(auth.error!,
                          style: const TextStyle(color: Colors.red)),

                    const SizedBox(height: 20),

                    CustomButton(
                      label: "Register",
                      loading: auth.isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success =
                          await context.read<AuthProvider>().register(
                            fullName: _fullNameCtrl.text.trim(),
                            email: _emailCtrl.text.trim(),
                            password: _passwordCtrl.text.trim(),
                          );
                          if (success && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Registration Successful")),
                            );
                            Navigator.pop(context); // back to login
                          }
                        }
                      },
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
}