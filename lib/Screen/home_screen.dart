import 'package:bloc_phone_auth/Screen/sign_in_screen.dart';
import 'package:bloc_phone_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          }
        }, builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logOut();
            },
            child: const Text("Log Out"),
          );
        }),
      ),
    );
  }
}
