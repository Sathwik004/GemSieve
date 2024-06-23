import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/fetch_diary_bloc_bloc.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/grammar_text_bloc.dart';
import 'package:milkydiary/features/add_diarytext/presentation/pages/entry_landing_page.dart';
import 'package:milkydiary/init_dependencies.dart';

class AddDiaryEntryPage extends StatefulWidget {
  const AddDiaryEntryPage({Key? key}) : super(key: key);

  @override
  _AddDiaryEntryPageState createState() => _AddDiaryEntryPageState();
}

class _AddDiaryEntryPageState extends State<AddDiaryEntryPage> {
  final TextEditingController _controller = TextEditingController();
  String remark="Well done, you have written your diary today, way to go!";
  String formatter =DateFormat('d MMMM, yyyy').format(DateTime.now());
  String emotionalState="normal day";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIconSelectionDialog();
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
   void _showIconSelectionDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How was your day?',style: GoogleFonts.poppins().copyWith(color:Colors.brown,fontSize:16 )),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.sentiment_very_dissatisfied, size: 30),
                onPressed: () {
                  emotionalState="Very bad day";
                  Navigator.of(context).pop();
                  // Handle very sad day selection
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_dissatisfied, size: 30),
                onPressed: () {
                  emotionalState="bad day";
                  Navigator.of(context).pop();
                  // Handle sad day selection
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_neutral, size: 30),
                onPressed: () {
                  emotionalState="normal day";
                  Navigator.of(context).pop();
                  // Handle neutral day selection
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_satisfied, size: 30),
                onPressed: () {
                  emotionalState="a good day";
                  Navigator.of(context).pop();
                  // Handle happy day selection
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_very_satisfied, size: 30),
                onPressed: () {
                  emotionalState="very good day";
                  Navigator.of(context).pop();
                  // Handle very happy day selection
                },
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  alignment: Alignment.center,
                height: 70,
                //  width: double.maxFinite,
                padding:
                    EdgeInsets.only(top: 12, left: 24, bottom: 12, right: 24),
                decoration: BoxDecoration(
                    color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  formatter,
                  style: GoogleFonts.caveat().copyWith(color: Colors.black,fontSize:28 )
             //     TextStyle(color: textcolor),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: pagecolor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      BlocBuilder<FetchDiaryBloc, FetchDiaryBlocState>(
                        builder: (context, state) {
                          if (state is FetchDiaryBlocInitial) {
                            return Expanded(
                              child: BlocBuilder<GrammarTextBloc, GrammarTextState>(
                                builder: (context1, state1) {
                                  if(state1 is GrammarTextInitial)
                                  {

                                  }
                                  else
                                  if(state1 is GrammarTextLoading)
                                  {
                                    _controller.text="Correcting your Grammer";
                                  }
                                  else if(state1 is GrammarTextSuccess)
                                  {
                                    _controller.text=state1.grammertext;
                                  }

                                  return Form(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        //      color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      minLines: null,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.transparent,
                                        hintText:
                                            "Write how your day was nigga!", //
                                      ),
                                      //   initialValue: "Enter the Diary text",
                                      controller: _controller,
                                    ),
                                  ));
                                },
                              ),
                            );
                          } else if (state is FetchDiaryLoading) {
                            return Expanded(
                              child: Text(
                                  "Loading, fetching your gemini diary now!"),
                            );
                          } else if (state is FetchDiarySuccess) {
                            _controller.text = state.output.diary;
                            print(_controller.text);
                            remark=state.output.remark;
                            return Expanded(child: Text(state.output.diary,style: GoogleFonts.caveat().copyWith(color: Colors.black,fontSize:24 )));
                          } else if (state is FetchDiaryFailure) {
                            return Text(state.message);
                          }
                          return Text("BLennn");
                        },
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.brown),
                              ),
                              onPressed: () {
                                context.read<FetchDiaryBloc>().add(
                                    FetchDiaryWithHabits(
                                        _controller.text+" emotional state: ${emotionalState}", "1. play guitar"));
                              },
                              child:  Text(
                                "Gemini diary",
                                style: GoogleFonts.poppins().copyWith(color: const Color.fromARGB(255, 255, 255, 255),fontSize:12 ),
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          ElevatedButton(
                             style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.brown),
                              ),
                              onPressed: () {
                            context.read<GrammarTextBloc>().add(FetchGrammerEvent(_controller.text));

                              }, child: Text("Grammer",style: GoogleFonts.poppins().copyWith(color: const Color.fromARGB(255, 255, 255, 255),fontSize:12 ))),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                // your taskk white nigga
                              },
                              icon: Icon(Icons.image)),
                          IconButton(
                              onPressed: () {
                                // your taskk white nigga
                              },
                              icon: Icon(Icons.mic)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(width: 150,),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async {
                     
                  await  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Remark"),
        content: Text(remark,style: GoogleFonts.lato().copyWith(color: Colors.black,fontSize:18 )),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Allow navigation
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
    print(_controller.text);
     Navigator.of(context).pop(
     _controller.text);
                        // Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.brown,
                            ),
                            borderRadius: BorderRadius.circular(24)),
                        child:  Center(
                          child: Text("Save",style: GoogleFonts.poppins().copyWith(color:Colors.brown,fontSize:16 )),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        remark="Well done, you have written your diary today, way to go!";
                        context
                            .read<FetchDiaryBloc>()
                            .add(FetchDiaryWithInitialEvent());
                      },
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.all(4),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.brown,
                            ),
                            borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Text("Edit",style: GoogleFonts.poppins().copyWith(color:Colors.brown,fontSize:16 )),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
