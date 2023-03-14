import 'package:bloc_phone_auth/Screen/verify_phone_number_screen.dart';
import 'package:bloc_phone_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_state.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text("Sign In with Phone"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Phone Number",
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
              child: BlocConsumer<AuthCubit, AuthState>(
                builder: (BuildContext context, state) {
                  if (state is AuthLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                      onPressed: () {
                        String phoneNumber = "+91${phoneController.text}";
                        BlocProvider.of<AuthCubit>(context)
                            .sendOtp(phoneNumber);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ));
                },
                listener: (BuildContext context, Object? state) {
                  if (state is AuthCodeSentState) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        VerifyPhoneNumberScreen()
                    ));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
