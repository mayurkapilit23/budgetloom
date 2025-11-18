import 'package:budgetloom/features/auth/bloc/auth_bloc.dart';
import 'package:budgetloom/features/auth/bloc/auth_state.dart';
import 'package:budgetloom/features/expense/presentation/screens/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/widgets/custom_button.dart';
import '../bloc/auth_event.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Close keyboard before navigating
              FocusScope.of(context).unfocus();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ExpenseScreen()),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logged in: ${state.userId}")),
              );
            }

            if (state is AuthError) {
              FocusScope.of(context).unfocus();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },

          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.indigoAccent.shade200,
                  size: 30,
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      "Login to continue your financial journey.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v!.isEmpty ? "Email required" : null,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (v) => v!.isEmpty ? "Password required" : null,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Login Button
                    CustomButton(
                      backgroundColor: AppColor.primaryFocusedColor,
                      text: 'Login',
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        context.read<AuthBloc>().add(
                          LoginEvent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.7),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text("Create Account"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
