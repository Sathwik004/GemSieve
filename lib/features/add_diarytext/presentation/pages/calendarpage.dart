// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/firebase_bloc.dart';

class Calendarpage extends StatefulWidget {
  Calendarpage({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  _CalendarpageState createState() => _CalendarpageState();
}

class _CalendarpageState extends State<Calendarpage> {
  List<entry> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FirebaseBloc>().add(FirebaseFetchDiaryEvent(widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            body: BlocBuilder<FirebaseBloc, FirebaseState>(
              builder: (context, state) {
                if (state is FirebaseFetchDiaryLoading)
                  return Center(
                    child: Text("Fetching your dary"),
                  );
                else if (state is FirebaseFetchDiarySuccess) {
                  //
                  print("yoo");
                  print(state.list[0].date);
                  //  chirag is facilty - \\ // \\ // \\ // \\ // \\ - + - // \\ - +
                  //              for (var map in state.list) {
                  //   map.forEach((key, value) {
                  //     String date = key;
                  //     String entries = value as String;  // Assuming the value is a string
                  //     list.add(entry(date: date, entries: entries));
                  //   });
                  // }

                  return ListView.builder(
                   // reverse: true,

                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        
                        trailing: IconButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content: Text(
                                      "You really want to delete this entry??"),
                                  actions: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        ElevatedButton(
                                            onPressed: () async {
                                              //        Navigator.of(context).pop();
                                              context.read<FirebaseBloc>().add(
                                                  FirebaseDeleteUserEntry(
                                                      date: state
                                                          .list[index].date,
                                                      email: widget.email));
                                              context.read<FirebaseBloc>().add(
                                                  FirebaseFetchDiaryEvent(
                                                      widget.email));
                                              Navigator.of(context).pop();
                                              //  await widget.instance.signOut();
                                            },
                                            child: Text("Yes")),
                                        ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No")),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete,size: 18,),
                        ),
                        // title: Text(
                        //   state.list[index].date.substring(6),
                        //   style: TextStyle(color: Colors.black),
                        // ),
                        title: ExpansionTile(
                          title: Text(
                            state.list[index].date.substring(6),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                             style: GoogleFonts.caveat()
                        .copyWith(color: Colors.black, fontSize: 22,fontWeight: FontWeight.w600)
                          ),
                          children: [Text(
                            "Time: "+state.list[index].date.substring(0,5)+"\n"+
                            state.list[index].entries,
                             style: GoogleFonts.caveat()
                        .copyWith(color: Colors.black, fontSize: 19)
                           // maxLines: 1,
                            //overflow: TextOverflow.ellipsis,
                          )],
                        ),
                      );
                    },
                  );
                }
                return Container(
                  child: Center(
                    child: Text("Add some diary entries"),
                  ),
                );
              },
            ),

            //   body: MonthView(

            //     borderColor: Colors.black,
            //     cellAspectRatio: 1,
            //     showBorder: false,
            //   //   headerStringBuilder: (date, {secondaryDate}) => date.toString(),
            //  //   width: 300,
            //     headerStyle: HeaderStyle(titleAlign: TextAlign.start,decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(24),color: Colors.brown,
            //     )),
            //      controller: EventController(),
            //      cellBuilder: (date, event, isToday, isInMonth, hideDaysNotInMonth){
            //       return Container(
            //         margin: EdgeInsets.all(3),
            //        // color: pagecolor,
            //         decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),color: pagecolor,
            //     ),
            //         height: 40,width: 90,
            //         child: isInMonth==true? const Center(child: Text("hi")):Center(child: Text("X")),
            //       );
            //      },

            //   ),
          ),
        ),
      ],
    );
  }
}

class entry {
  String date;
  String entries;
  entry({
    required this.date,
    required this.entries,
  });
}
