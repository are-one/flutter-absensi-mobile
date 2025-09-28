import 'package:flutter/material.dart';
import 'package:flutter_absensi_app/core/core.dart';
import 'package:flutter_absensi_app/presentation/auth/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/logout/logout_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error), backgroundColor: Colors.red),
                  );
                },
                success: () {
                  context.pushReplacement(const LoginPage());
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      context.read<LogoutBloc>().add(
                        const LogoutEvent.logout(),
                      );
                    },
                    label: 'Logout',
                  );
                },
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
