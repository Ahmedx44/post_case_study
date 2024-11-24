import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:post_case_study/features/common/auth/login/presentation/bloc/login_cubit.dart';
import 'package:post_case_study/features/common/auth/login/presentation/bloc/login_state.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: ScreenTypeLayout.builder(
        mobile: (context) => _mobileView(context),
        tablet: (context) => _tabletView(context),
        desktop: (context) => _desktopView(context),
      ),
    );
  }

  // Mobile View
  Widget _mobileView(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStateLoaded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Success')));
        }
        if (state is LoginStateError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Failed')));
        }
        if (state is LoginStateAdmin) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/admin_home');
          });
        } else if (state is LoginStateCashier) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/cashier_home');
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                    context: context,
                    label: 'Username',
                    controller: usernameController),
                const SizedBox(height: 16),
                _buildTextField(
                    label: 'Password',
                    context: context,
                    isPassword: true,
                    controller: passwordController),
                const SizedBox(height: 24),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().login(
                              usernameController.text, passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Tablet View
  Widget _tabletView(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStateLoaded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Success')));
        }

        if (state is LoginStateError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Failed')));
        }
        if (state is LoginStateAdmin) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.pop('/admin_home');
          });
        } else if (state is LoginStateCashier) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.pop('/cashier_home');
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.5,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField(
                      label: 'Username',
                      context: context,
                      controller: usernameController),
                  const SizedBox(height: 24),
                  _buildTextField(
                      label: 'Password',
                      isPassword: true,
                      context: context,
                      controller: passwordController),
                  const SizedBox(height: 32),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<LoginCubit>().login(
                                usernameController.text,
                                passwordController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Desktop View
  Widget _desktopView(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStateLoaded) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Success')));
        }
        if (state is LoginStateError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Failed')));
        }
        if (state is LoginStateAdmin) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/admin_home');
          });
        } else if (state is LoginStateCashier) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/cashier_home');
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.4,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField(
                    context: context,
                    label: 'Username',
                    controller: usernameController),
                const SizedBox(height: 24),
                _buildTextField(
                    label: 'Password',
                    context: context,
                    isPassword: true,
                    controller: passwordController),
                const SizedBox(height: 32),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().login(
                              usernameController.text, passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required BuildContext context,
      required String label,
      bool isPassword = false,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
