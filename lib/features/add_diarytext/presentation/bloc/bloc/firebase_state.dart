part of 'firebase_bloc.dart';

@immutable
sealed class FirebaseState {}

final class FirebaseInitial extends FirebaseState {}


// fetch user details page
final class FetchUserDetailsStateSuccess extends FirebaseState{
final String name;
final String email;
final String photoURL;
FetchUserDetailsStateSuccess({required this.email,required this.name,required this.photoURL});
}

final class FetchUserDetailsLoadingState extends FirebaseState{}

final class FetchUserDetailsFailed extends FirebaseState{}

// fetch diary states
final class FirebaseFetchDiaryLoading extends FirebaseState{}
final class FirebaseFetchDiarySuccess extends FirebaseState{
  final List<entry> list;
  FirebaseFetchDiarySuccess(this.list);
}

//  delete the user records
final class FirebaseDeleteDiaryLoading extends FirebaseState{
}

final class FirebaseDeleteSuccess extends FirebaseState{}