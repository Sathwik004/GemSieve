import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/fetch_diary_bloc_bloc.dart';
import 'package:milkydiary/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:milkydiary/features/auth/data/repositories/authrepo_imp.dart';
import 'package:milkydiary/features/auth/domain/usecases/user_sign_in.dart';
import 'package:milkydiary/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:milkydiary/features/auth/presentation/pages/sign_up_page.dart';
import 'package:milkydiary/firebase_options.dart';
import 'package:milkydiary/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initdependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              userSignIn: UserSignIn(
                authRepo: AuthRepoImp(
                  authRemoteDataSource: AuthRemoteDataSourceImpl(
                    firebaseAuth: FirebaseAuth.instance,
                    googleSignIn: GoogleSignIn(),
                  ),
                ),
              ),
            ),
          ),
         
         // fetch diary bloc provider 
         BlocProvider(create: (_){
          return sl<FetchDiaryBloc>();
         })
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
              return Scaffold(
              appBar: AppBar(
                title: const Text('Milky Diary'),
              ),
              body: Center(
                child: Text(state.userId),
              ),
            );
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
