import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:milkydiary/core/themes/apppallete.dart';
import 'package:milkydiary/features/add_diarytext/presentation/bloc/bloc/fetch_diary_bloc_bloc.dart';
import 'package:milkydiary/init_dependencies.dart';

class AddDiaryEntryPage extends StatefulWidget {
  const AddDiaryEntryPage({Key? key}) : super(key: key);

  @override
  _AddDiaryEntryPageState createState() => _AddDiaryEntryPageState();
}

class _AddDiaryEntryPageState extends State<AddDiaryEntryPage> {
  final TextEditingController _controller = TextEditingController();

  String formatter = DateFormat('yMd').format(DateTime.now());
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  alignment: Alignment.center,
                height: 50,
                //  width: double.maxFinite,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: pagecolor, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  formatter,
                  style: TextStyle(color: textcolor),
                ),
              ),
              SizedBox(
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
                            return Form(
                                child: Container(
                              decoration: BoxDecoration(
                            //      color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                maxLines: 12,
                                decoration: const InputDecoration(
                                 
                                  hintText: "Write how your day was nigga!"
                                ),
                                //   initialValue: "Enter the Diary text",
                                controller: _controller,
                              ),
                            ));
                          } else if (state is FetchDiaryLoading) {
                            return Text("Loading");
                          } else if (state is FetchDiarySuccess) {
                            return Text(state.output.diary);
                          } else if (state is FetchDiaryFailure) {
                            return Text(state.message);
                          }
                          return Text("BLennn");
                        },
                      ),
                      Spacer(),
                      Row(
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                context.read<FetchDiaryBloc>().add(
                                    FetchDiaryWithHabits(
                                        _controller.text, "1. play guitar"));
                              },
                              child: const Text("Fetch diaryyy")),
                          OutlinedButton(
                              onPressed: () {
                                context
                                    .read<FetchDiaryBloc>()
                                    .add(FetchDiaryWithInitialEvent());
                              },
                              child: const Text("Edit Text")),
                              Spacer(),
                              IconButton(onPressed: (){
                                // your taskk white nigga
                              }, icon: Icon(Icons.mic))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
