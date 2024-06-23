
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/add_diary_entry_page.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/calendarpage.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/entry_landing_page.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/userpage.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth instance;
  HomeScreen(this.instance);
  @override


  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  static final List<Widget> _widgetOptions = <Widget>[
        Calendarpage(),
     const EntryLandingPage(),
      const UserPage(),
   
   
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("My Milky Diary",style: GoogleFonts.poppins().copyWith(color:Colors.brown,fontSize:24 )),
        actions: [
          TextButton(onPressed: () async{
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("You really want to log out??"),
          actions: [
            Row(
              children: [
                Spacer(),
                ElevatedButton(onPressed: ()async{     
                     Navigator.of(context).pop();  
                 await widget.instance.signOut();
                 }
                , child: Text("Yes")),
                 ElevatedButton(onPressed: ()async{       
                Navigator.of(context).pop();
                 }
                , child: Text("No")),
              ],
            )
          ],
        );
      },
    );
  },

          child:  Text("Sign Out",style: GoogleFonts.poppins().copyWith(color:Colors.brown,fontSize:16 )))
        ],
      ),
      body: 
   
      Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            
            icon: Icon(Icons.add),
            label: 'Add Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
         
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class AddDiaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add Diary Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Calendar Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}