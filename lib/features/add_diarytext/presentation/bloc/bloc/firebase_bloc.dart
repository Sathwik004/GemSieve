import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/calendarpage.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final db = FirebaseFirestore.instance;
  FirebaseBloc() : super(FirebaseInitial()) {
    on<FirebaseEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FireBaseRegisterUserEvent>((event, emit) async {
      // TODO: implement event handler
      print("i'm here");
      final data = <String, dynamic>{"email": event.email, "name": event.name};
      await db.collection("Users").doc(event.email)!.set({
        "name": event.name,
        "email": event.email,
        "photourl": event.photourl
      });
    });
    on<FetchUserDetailsEvent>((event, emit) async {
      // TODO: implement event handler
      emit(FetchUserDetailsLoadingState());

      final response = await db.collection("Users").doc(event.email).get();
      print(response.get('name'));
      emit(
        FetchUserDetailsStateSuccess(
          email: response.get('email'),
          name: response.get('name'),
          photoURL: response.get('photourl'),
        ),
      );
    });

    on<FirebaseAddDiaryEntryEvent>((event, emit) async {
      // TODO: implement event handler
      await db
          .collection("diary")
          .doc(event.email)
          .collection("entries")
          .doc(event.date)
          .set({event.date: event.entry});
    });

    on<FirebaseFetchDiaryEvent>((event, emit) async {
      emit(FirebaseFetchDiaryLoading());
      // TODO: implement event handler
      final response = await db
          .collection("diary")
          .doc(event.email)
          .collection("entries")
          .get();
      List<Map<String, dynamic>> maps = [];
      for (var doc in response.docs) {
        maps.add(doc.data());
      }

      List<entry> ent = [];
      for (var map in maps) {
        map.forEach((key, value) {
          String date = key;
          String entries = value as String; // Assuming the value is a string
          ent.add(entry(date: date, entries: entries));
        });
      }
      ent.reversed.toList();
      emit(FirebaseFetchDiarySuccess(ent));
      //  print(maps[0]);
    });

    on<FirebaseDeleteUserEntry>(
      (event, emit)async {
        // TODO: implement event handler
       
          emit(FirebaseDeleteDiaryLoading());
          
          await db.collection("diary").doc(event.email).collection("entries").doc(event.date).delete();
          emit(FirebaseDeleteSuccess());
      },
    );
  }
}
