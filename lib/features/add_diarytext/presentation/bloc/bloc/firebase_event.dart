part of 'firebase_bloc.dart';

@immutable
sealed class FirebaseEvent {}

final class FireBaseRegisterUserEvent extends FirebaseEvent{
  final String email;
  final String name;
  final String photourl;
  FireBaseRegisterUserEvent({required this.email,required this.name,required this.photourl});
}

final class FirebaseAddDiaryEntryEvent extends FirebaseEvent{
 final String date;
  final String entry;
  final String email;
  FirebaseAddDiaryEntryEvent({required this.date,required this.entry,required this.email});
}

 class FireBaseAddHabitsEvent extends FirebaseEvent{

  final String habits;
  FireBaseAddHabitsEvent({required this.habits});

}

final class FirebaseFetchDiaryEvent extends FirebaseEvent{
  final String email;
  FirebaseFetchDiaryEvent(this.email);
}

final class FetchUserDetailsEvent extends FirebaseEvent{
  final String email;
  FetchUserDetailsEvent(this.email);
}

// delete event 
final class FirebaseDeleteUserEntry extends FirebaseEvent{
  final String date;
  final String email;
  FirebaseDeleteUserEntry({required this.date,required this.email});  
}