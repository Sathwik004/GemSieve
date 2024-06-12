import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/fetch_diary_bloc_bloc.dart';
import 'package:milkydiary/init_dependencies.dart';
import 'package:milkydiary/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:milkydiary/features/auth/presentation/pages/sign_up_page.dart';
import 'package:milkydiary/homepage.dart';
import 'package:milkydiary/firebase_options.dart';
//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => serviceLocater<AuthBloc>()
          ),
         
         // fetch diary bloc provider 
         BlocProvider<FetchDiaryBloc>(create: (context){
          return serviceLocater<FetchDiaryBloc>();
         })
          //pass your BlocProviders here
        ],
        child: const MyHomePage(),
     
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: "MY App" ,
      home: BlocBuilder<AuthBloc,AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const SignInPage();
          } else if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccessState) {
            final instance=FirebaseAuth.instance;
            return StreamBuilder(
              //Help required, Idk about this part. I want to emit state depending on authChanges
              stream: instance.authStateChanges(),
              builder: (context, snapshot) {
             if(snapshot.hasData)
              {
              return HomeScreen(instance);
              }
             return SignInPage();
              
              
               // context.read<AuthBloc>().add(AuthChanges());
              
              }
            );
          } else if (state is AuthFailureState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
