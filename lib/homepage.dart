import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/calendarpage.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/entry_landing_page.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/userpage.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth instance;
  const HomeScreen(this.instance,{super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
//

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

   final List<Widget> widgetOptions = <Widget>[
        Calendarpage(email:widget.instance.currentUser!.email! ,),
      EntryLandingPage(email: widget.instance.currentUser!.email!,),
       UserPage(instance: widget.instance,),
  ];

    return Scaffold(
      appBar: AppBar(
        title:  Text("My Diary",style: GoogleFonts.poppins().copyWith(color:Colors.brown,fontSize:24 )),
        actions: [
          TextButton(onPressed: () async{
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text("You really want to log out??"),
          actions: [
            Row(
              children: [
                const Spacer(),
                ElevatedButton(onPressed: ()async{     
                     Navigator.of(context).pop();  
                 await widget.instance.signOut();
                 }
                , child: const Text("Yes")),
                 ElevatedButton(onPressed: ()async{       
                Navigator.of(context).pop();
                 }
                , child:const Text("No")),
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
        child: widgetOptions.elementAt(_selectedIndex,),
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

  const AddDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Add Diary Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {

  const CalendarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Calendar Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}