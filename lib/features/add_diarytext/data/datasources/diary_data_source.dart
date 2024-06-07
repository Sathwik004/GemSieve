import 'package:milkydiary/core/secrets/apikey.dart';
import 'package:milkydiary/features/add_diarytext/data/models/geminidiarytextmodel.dart';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
abstract interface class DiaryDataSource{
Future<GeminiDiaryTextModel> fetchdiary(String input,String habits);
}


class DiaryDataSourceImple implements DiaryDataSource{
  @override
  Future<GeminiDiaryTextModel> fetchdiary(String input, String habits) async{

 const String apiKey = ApiKey.key;

    // Define generation configuration
    final GenerationConfig generationConfig = GenerationConfig(
      temperature: 1.0,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: "text/plain",
    );

    // Define safety settings
    // final List<SafetySetting> safetySettings = [
    //   SafetySetting(HarmCategory.HARASSMENT, BlockThreshold.MEDIUM_AND_ABOVE),
    //   SafetySetting(HarmCategory.HATE_SPEECH, BlockThreshold.MEDIUM_AND_ABOVE),
    //   SafetySetting(HarmCategory.SEXUALLY_EXPLICIT, BlockThreshold.MEDIUM_AND_ABOVE),
    //   SafetySetting(HarmCategory.DANGEROUS_CONTENT, BlockThreshold.MEDIUM_AND_ABOVE),
    // ];

    // Define system instruction
    final String systemInstruction = """
    You are a machine such that the user will give you certain points of his day, and you will generate a diary paragraph from the points. 
    
    user will provide an emotional state of my day with the field "emotional state:". Generate text with correspondence of my emotional state.
    
    The user has a habit of following things:
   $habits
    
    Now, based on the habits listed and the points of user's day you should also generate a remark section after the diary paragraph text with the heading "Remark". 
    
    In the remark section,
    if in the points of the user's day, user has not included the habit or if user didn't perform the habit, then please remind user to follow the habit the following day, motivating user with the importance of the habit.
    if the user has made the habit, then congratulate the user for doing so. 
    Make sure to write about all the habits in the remark section, without excluding any of them. Write remark as a paragraph.
    """;

    // Create GenerativeModel instance
    final model = GenerativeModel(
      model: "gemini-1.5-flash",
      apiKey: apiKey,
      generationConfig: generationConfig,
     // safetySettings: safetySettings,
      systemInstruction: Content.text(systemInstruction),
    );

    // Define empty chat history
    final List<Content> chatHistory = [];

    // Start chat session
    final chat = model.startChat(history:  chatHistory);

    // Send message and get response

    try{
      final response = await chat.sendMessage(Content.text(input));
    String para=response.text!;
    return GeminiDiaryTextModel.fromJson(para);

    } catch(e)
    {
      throw ServerException(e.toString());
    }
    
  
  //  Future<String> s=response.text;
  //  print(response.text);
  
    // Return the first text part
  //  return response.text;
  

}
}