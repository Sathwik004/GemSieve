import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/firebase_bloc.dart';

class UserPage extends StatefulWidget {
  final FirebaseAuth instance;
  const UserPage({Key? key, required this.instance}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
 String username="NO name";
  String email="no mail";
  String photo="null";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<FirebaseBloc>()
        .add(FetchUserDetailsEvent(widget.instance.currentUser!.email!));
  }

  bool _isDark = false;
  @override
  Widget build(BuildContext context) {

    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Column(
        children: [
          BlocBuilder<FirebaseBloc, FirebaseState>(
            builder: (context, state) {
              if(state is FetchUserDetailsStateSuccess)
              {
                  username=state.name;
                  email=state.email;
                  photo=state.photoURL;

              }
              return Container(
                //color: const Color.fromARGB(255, 223, 223, 223),

                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                height: 150,
                child: Row(
                  children: [
                    if(photo!="null")
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12)),
                          child: Image(image: NetworkImage(photo)),
                      //color: Colors.grey,
                    ), // image container
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(username,
                            style: GoogleFonts.raleway()
                                .copyWith(color: Colors.brown, fontSize: 18)),
                        SizedBox(
                          height: 12,
                        ),
                        Text(email,
                            style: GoogleFonts.raleway()
                                .copyWith(color: Colors.brown, fontSize: 14))
                      ],
                    )
                  ],
                ),
              );
            },
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
                              title: "Profile",
                              icon: Icons.person_outline_rounded),
                          _CustomListTile(
                              type: "mid",
                              title: "Messaging",
                              icon: Icons.message_outlined),
                          _CustomListTile(
                              type: "mid",
                              title: "Calling",
                              icon: Icons.phone_outlined),
                          _CustomListTile(
                              type: "mid",
                              title: "People",
                              icon: Icons.contacts_outlined),
                          _CustomListTile(
                              type: "down",
                              title: "Calendar",
                              icon: Icons.calendar_today_rounded)
                        ],
                      ),
                      const Divider(),
                      _SingleSection(
                        children: [
                          const _CustomListTile(
                              type: "top",
                              title: "Help & Feedback",
                              icon: Icons.help_outline_rounded),
                          _CustomListTile(
                              type: "mid",
                              title: "About",
                              icon: Icons.info_outline_rounded),
                          GestureDetector(
                            onTap: () async {
                              await widget.instance.signOut();
                            },
                            child: _CustomListTile(
                                type: "down",
                                title: "Sign out",
                                icon: Icons.exit_to_app_rounded),
                          ),
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
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration box = BoxDecoration();
    switch (type) {
      case "top":
        box = BoxDecoration(
            color: pagecolor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)));
        break;
      case "mid":
        box = BoxDecoration(
          color: pagecolor,
          //  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        );
        break;
      case "down":
        box = BoxDecoration(
            color: pagecolor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)));
        break;
    }
    return Container(
      decoration: box!,
      child: ListTile(
        // tileColor: pagecolor,

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
