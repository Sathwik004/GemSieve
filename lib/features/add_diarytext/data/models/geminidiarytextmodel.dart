import 'package:milkydiary/features/add_diarytext/domian/entities/geminidiarytext.dart';

class GeminiDiaryTextModel extends GeminiDiaryText {
  GeminiDiaryTextModel({
    required super.diary,
    required super.remark,
  });

  factory GeminiDiaryTextModel.fromJson(String paragraph){
    //code to parse the text and the 
    
    // hello there, wassuppp
   return GeminiDiaryTextModel(diary: "", remark: "");
  }
}
