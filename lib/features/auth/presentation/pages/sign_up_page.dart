import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/features/auth/presentation/bloc/auth_bloc_bloc.dart';

class SignInPage extends StatefulWidget{

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign Up', style: TextStyle(fontSize: 32),),
            const SizedBox(height: 20,),
            ElevatedButton.icon(onPressed: (){context.read<AuthBloc>().add(AuthSignIn(),);}, icon: const Icon(Icons.circle),label:const Text('Sign Up using google')),
          ],
        ),
      ),
    );
  }
}