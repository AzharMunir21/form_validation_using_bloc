import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block/sign_in_block.dart';
import 'block/sign_in_event.dart';
import 'block/sign_in_state.dart';

class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In with Email"),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<SignInBlock, SignInState>(
                  builder: (context, state) {
                    if (state is SignInErrorState) {
                      return Text(
                        "${state.errorMessage}",
                        style: const TextStyle(color: Colors.red),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email Address",
                  ),
                  onChanged: (val) {
                    BlocProvider.of<SignInBlock>(context).add(
                        SignInTextChangeEvent(
                            emailValue: emailController.text,
                            passwordValue: passwordController.text));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: "Password"),
                  onChanged: (val) {
                    BlocProvider.of<SignInBlock>(context).add(
                        SignInTextChangeEvent(
                            emailValue: emailController.text,
                            passwordValue: passwordController.text));
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocBuilder<SignInBlock, SignInState>(
                    builder: (context, state) {
                  if (state is SignInLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      height: 56,
                      color: (state is SignInErrorState)
                          ? Colors.grey
                          : Colors.blue,
                      child: TextButton(
                        onPressed: () {
                          if (emailController.text.isEmpty &&
                              passwordController.text.isEmpty) {
                            BlocProvider.of<SignInBlock>(context).add(
                                SignInTextChangeEvent(
                                    emailValue: emailController.text,
                                    passwordValue: passwordController.text));
                          }
                          BlocProvider.of<SignInBlock>(context).add(
                              SignInSubmittedEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                })
              ],
            )),
      ),
    );
  }
}
