import 'package:milkydiary/features/add_diarytext/domian/entities/grammertext.dart';

class GrammerTextModel extends GrammerText{
  GrammerTextModel({required super.correntedtext});

factory GrammerTextModel.fromJson(String grammertext)
{
  return GrammerTextModel(correntedtext: grammertext);
}
}