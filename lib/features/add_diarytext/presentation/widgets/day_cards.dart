// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/add_diary_entry_page.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/entry_landing_page.dart';

class DayCards extends StatefulWidget {
  const DayCards({
    Key? key,
    required this.content,
    required this.email
  }) : super(key: key);
  final String content;
  final String email;
  @override
  State<DayCards> createState() => _DayCardsState();
}

class _DayCardsState extends State<DayCards> {
  String formatter = DateFormat('d MMMM, yyyy').format(DateTime.now());
    String formatter1 = DateFormat('HH:mm d MMMM, yyyy').format(DateTime.now());
  String contents = "";
  String Date = "";
  @override
  Widget build(BuildContext context) {
    print(formatter1);
    return GestureDetector(
      //    key: ValueKey(1),
      onTap: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(
          builder: (context) => AddDiaryEntryPage(email: widget.email,),
        ))
            .then(
          (value) {
            setState(
              () {
                contents = value;
              },
            );
          },
        );
        return;
      },
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: pagecolor,
        ),
        child: contents == ""
            ? Text(
                widget.content,
                style: TextStyle(color: Colors.black),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatter,
                    style: GoogleFonts.caveat()
                        .copyWith(color: Colors.black, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    contents,
                    style: GoogleFonts.caveat()
                        .copyWith(color: Colors.black, fontSize: 24),
                  ),
                ],
              ),
      ),
    );
  }
}
