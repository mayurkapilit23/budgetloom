import 'package:budgetloom/features/auth/bloc/auth_bloc.dart';
import 'package:budgetloom/features/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/widgets/custom_button.dart';
import '../bloc/auth_event.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,

      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              FocusScope.of(context).unfocus();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Registered: ${state.userId}")),
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
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Join BudgetLoom and start weaving your savings!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Full Name
                    TextFormField(
                      controller: nameController,
                      validator: (v) =>
                          v!.isEmpty ? "Full name required" : null,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

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
                      validator: (v) =>
                          v!.length < 6 ? "Min 6 chars password" : null,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Register Button
                    CustomButton(
                      backgroundColor: AppColor.primaryFocusedColor,
                      text: 'Sign Up',
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        context.read<AuthBloc>().add(
                          RegisterEvent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );

                        emailController.clear();
                        passwordController.clear();
                        nameController.clear();
                      },
                    ),

                    const SizedBox(height: 30),

                    // Go to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.7),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Login"),
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
