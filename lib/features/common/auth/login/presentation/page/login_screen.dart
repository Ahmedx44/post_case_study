import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/common/auth/login/presentation/bloc/login_cubit.dart';
import 'package:post_case_study/features/common/auth/login/presentation/bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header or any logo can be added here
                Center(
                  child: Text(
                    'Login',
                  ),
                ),
                const SizedBox(height: 40),

                // Email Input
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 20),

                // Password Input
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 20),

                // Login Button
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onError),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                    }

                    if (state is LoginStateLoaded) {
                      print('Navigate to Home');
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          context.read<LoginCubit>().login(email, password);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 100.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
