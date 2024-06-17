import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calendarpage extends StatefulWidget {
  const Calendarpage({ Key? key }) : super(key: key);

  @override
  _CalendarpageState createState() => _CalendarpageState();
}

class _CalendarpageState extends State<Calendarpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Expanded(
          child: Scaffold(
            body: MonthView(
              weekDayStringBuilder: (p0) {
                return p0.toString();
              },
              borderColor: Colors.black,
              cellAspectRatio: 1,
              showBorder: false,
            //   headerStringBuilder: (date, {secondaryDate}) => date.toString(),
           //   width: 300,
              headerStyle: HeaderStyle(titleAlign: TextAlign.start,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),color: const Color.fromARGB(255, 141, 135, 77),
              )),
               controller: EventController(),
               cellBuilder: (date, event, isToday, isInMonth, hideDaysNotInMonth){
                return Container(
                  margin: EdgeInsets.all(3),
                  color: Colors.grey,
                  height: 40,width: 90,
                  child: isInMonth==true? const Center(child: Text("hi")):Center(child: Text("bleh")),
                );
               },
          
            ),
            
          ),
        ),
        Container(height: 200,)
      ],
    );
  }
}