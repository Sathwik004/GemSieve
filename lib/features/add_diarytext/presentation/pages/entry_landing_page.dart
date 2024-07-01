// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/add_diary_entry_page.dart';
import 'package:milkydiary/features/add_diarytext/presentation/widgets/day_cards.dart';
import 'package:milkydiary/features/add_diarytext/presentation/widgets/month_cards.dart';

class EntryLandingPage extends StatefulWidget {
   EntryLandingPage({Key? key,required this.email}) : super(key: key);
  String email;
  @override
  _EntryLandingPageState createState() => _EntryLandingPageState();
}

class _EntryLandingPageState extends State<EntryLandingPage> {
  String greetuser() {
    final currenttime = DateTime.now();
    final hours = currenttime.hour;
    if (hours < 12) {
      return "Good Moring,";
    } else if (hours < 18) {
      return "Good Afternoon,";
    } else
      // ignore: curly_braces_in_flow_control_structures
      return "Good Evening,";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  greetuser(),
                  style: GoogleFonts.caveat().copyWith(color: Colors.black,fontSize:32 )),
                
                const Spacer(),
                // Container(
                //   width: 40,
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(Radius.circular(12)),
                //     color: pagecolor,
                //   ),
                //   child: const Padding(
                //     padding: EdgeInsets.all(4),
                //     child: Column(
                //       children: [
                //         Icon(Icons.calendar_today_rounded),
                //         SizedBox(
                //           height: 4,
                //         ),
                //         Text("S")
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
         
            // SizedBox(
            //   height: 12,
            // ),
            Expanded(
              child: DayCards(content: "I would like to write about my day that..",email: widget.email,)
            ),
          ],
        ),
      ),
    );
  }
}

class DiaryEntry {
 final String date;
 final String content;
  DiaryEntry({
    required this.date,
    required this.content,
  });
}
