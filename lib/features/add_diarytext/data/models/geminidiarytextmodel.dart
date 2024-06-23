import 'package:milkydiary/features/add_diarytext/domian/entities/geminidiarytext.dart';

class GeminiDiaryTextModel extends GeminiDiaryText {
  GeminiDiaryTextModel({
    required super.diary,
    required super.remark,
  });

  factory GeminiDiaryTextModel.fromJson(String paragraph){
    //code to parse the text and the 
    print(paragraph);
    // hello there, wassuppp
    List<String> parts=paragraph.split('\n\n');
    String para=parts[0].trim();
    String remark=parts[1].replaceFirst('**Remark:**', '');

   return GeminiDiaryTextModel(diary: para, remark: remark);
  }
}
