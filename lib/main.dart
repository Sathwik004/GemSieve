import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/features/speech_to_text/speech_to_text_widgets.dart';
import 'package:milkydiary/init_dependencies.dart';
import 'package:milkydiary/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:milkydiary/features/auth/presentation/pages/sign_up_page.dart';
import 'package:milkydiary/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milky Diary',
      theme: null,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => serviceLocater<AuthBloc>(),
          ),

          //pass your BlocProviders here
        ],
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return const SignInPage();
        } else if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthSuccessState) {
          return StreamBuilder(
            //Help required, Idk about this part. I want to emit state depending on authChanges
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              context.read<AuthBloc>().add(AuthChanges());
              return SpeechToTextWidget();
            }
          );
        } else if (state is AuthFailureState) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
