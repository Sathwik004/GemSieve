// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/add_diary_entry_page.dart';
import 'package:milkydiary/features/add_diarytext/presentation/widgets/day_cards.dart';
import 'package:milkydiary/features/add_diarytext/presentation/widgets/month_cards.dart';

class EntryLandingPage extends StatefulWidget {
  const EntryLandingPage({Key? key}) : super(key: key);

  @override
  _EntryLandingPageState createState() => _EntryLandingPageState();
}

class _EntryLandingPageState extends State<EntryLandingPage> {
  String greetuser() {
    final currenttime = DateTime.now();
    final hours = currenttime.hour;
    if (hours < 12) {
      return "Good Moring";
    } else if (hours < 18) {
      return "Good Afternoon";
    } else
      // ignore: curly_braces_in_flow_control_structures
      return "Good Evening";
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
                  greetuser() + ",",
                  style: TextStyle(fontSize: 32),
                ),
                Spacer(),
                Container(
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: pagecolor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: const Column(
                      children: [
                        Icon(Icons.calendar_today_rounded),
                        SizedBox(
                          height: 4,
                        ),
                        Text("S")
                      ],
                    ),
                  ),
                )
              ],
            ),
            Text(
              "Dear User",
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: DefaultTabController(
                length: 7,
                child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(
                        // labelPadding: EdgeInsets.symmetric(horizontal: 2),
                        indicator: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          //  color: boxcolor,
                        ),
                        indicatorColor: boxcolor,
                        // labelColor: Colors.blue,
                        padding: EdgeInsets.all(2),
                        tabs: const [
                          MonthCards(num: 0),
                          MonthCards(num: 1),
                          MonthCards(num: 2),
                          MonthCards(num: 3),
                          MonthCards(num: 4),
                          MonthCards(num: 5),
                          MonthCards(num: 6),
                        ],
                      ),
                    ),
                    body: const TabBarView(children: [
                      DayCards(content: "Today my day was like..."),
                      DayCards(content: "My Day was"),
                      DayCards(content: "My Day was"),
                      DayCards(content: "My Day was"),
                      DayCards(content: "My Day was"),
                      DayCards(content: "My Day was"),
                      DayCards(content: "My Day was")
                    ])),
              ),
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
