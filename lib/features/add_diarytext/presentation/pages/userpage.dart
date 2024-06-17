import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Column(
        children: [
        
            Container(
              //color: const Color.fromARGB(255, 223, 223, 223),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(12)
              ),
             margin: const EdgeInsets.all(12),
             padding: const EdgeInsets.all(12),
             height: 200,
             child: Row(
              children: [
                Container(
                height: 150,
                width: 120,
                color: Colors.grey,
                ),// image container
               const SizedBox(width: 12,),
               const Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                         Text("Chirag S "),
                         SizedBox(height: 30,),
                         Text("hahaha@gmail.com ")
                ],
               )
              ],
             ),
            ),
          
          Expanded(
            child: Scaffold(
            
              body: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ListView(
                    children: [
                      _SingleSection(
                        title: "General",
                        children: [
                          _CustomListTile(
                            type: "top",
                              title: "Dark Mode",
                              icon: Icons.dark_mode_outlined,
                              trailing: Switch(
                                  value: _isDark,
                                  onChanged: (value) {
                                    setState(() {
                                      _isDark = value;
                                    });
                                  })),
                          const _CustomListTile(
                            type: "mid",
                              title: "Notifications",
                              icon: Icons.notifications_none_rounded),
                          const _CustomListTile(
                            type: "down",
                              title: "Security Status",
                              icon: CupertinoIcons.lock_shield),
                        ],
                      ),
                      const Divider(),
                      const _SingleSection(
                        title: "Organization",
                        children: [
                          
                          _CustomListTile(
                            type: "top",
                              title: "Profile", icon: Icons.person_outline_rounded),
                          _CustomListTile(
                            type: "mid",
                              title: "Messaging", icon: Icons.message_outlined),
                          _CustomListTile(
                            type: "mid",
                              title: "Calling", icon: Icons.phone_outlined),
                          _CustomListTile(
                            type: "mid",
                              title: "People", icon: Icons.contacts_outlined),
                          _CustomListTile(
                            type: "down",
                              title: "Calendar", icon: Icons.calendar_today_rounded)
                        ],
                      ),
                      const Divider(),
                      const _SingleSection(
                        children: [
                          _CustomListTile(
                            type: "top",
                              title: "Help & Feedback",
                              icon: Icons.help_outline_rounded),
                          _CustomListTile(
                            type: "mid",
                              title: "About", icon: Icons.info_outline_rounded),
                          _CustomListTile(
                            type: "down",
                              title: "Sign out", icon: Icons.exit_to_app_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final String type;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing,required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration box=BoxDecoration(); 
    switch(type)
    {
      case "top":
      box= BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
      );
      break;
       case "mid":
      box= BoxDecoration(
        color: Colors.green,
      //  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
      );
      break;
      case "down":
      box= BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
      );
      break;

    }
    return Container(
      decoration: box!,
      child: ListTile(
       // tileColor: Colors.green,
      
        title: Text(title),
        leading: Icon(icon),
        trailing: trailing,
        onTap: () {},
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
