import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/admin/home/presentation/admin_home.dart';
import 'package:post_case_study/features/cashier/home/presentation/cashier_home.dart';
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
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                    label: 'Username', controller: usernameController),
                const SizedBox(height: 16),
                _buildTextField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController),
                const SizedBox(height: 24),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LoginStateAdmin) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const AdminHome();
                        },
                      ));
                      return const SizedBox.shrink();
                    } else if (state is LoginStateCashier) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const CashierHome();
                        },
                      ));
                      return const SizedBox.shrink();
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().login(
                              usernameController.text, passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.5,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField(
                      label: 'Username', controller: usernameController),
                  const SizedBox(height: 24),
                  _buildTextField(
                      label: 'Password',
                      isPassword: true,
                      controller: passwordController),
                  const SizedBox(height: 32),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LoginStateAdmin) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const AdminHome();
                          },
                        ));
                        return const SizedBox.shrink();
                      } else if (state is LoginStateCashier) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const CashierHome();
                          },
                        ));
                        return const SizedBox.shrink();
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<LoginCubit>().login(
                                usernameController.text,
                                passwordController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
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
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.4,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField(
                    label: 'Username', controller: usernameController),
                const SizedBox(height: 24),
                _buildTextField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController),
                const SizedBox(height: 32),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoginStateAdmin) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const AdminHome();
                        },
                      ));
                      return const SizedBox.shrink();
                    } else if (state is LoginStateCashier) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const CashierHome();
                        },
                      ));
                      return const SizedBox.shrink();
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().login(
                              usernameController.text, passwordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
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

  // Common TextField Widget
  Widget _buildTextField({
    required String label,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
