import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:milkydiary/core/secrets/apikey.dart';
import 'package:milkydiary/features/add_diarytext/data/models/grammertextmodel.dart';

abstract interface  class Grammartextdatasource{
  Future<GrammerTextModel> fetchgrammar(String input);
}

class GrammerTextdatasourceimpl implements Grammartextdatasource{
  @override
  Future<GrammerTextModel> fetchgrammar(String input) async {
// Define generation configuration
    final GenerationConfig generationConfig = GenerationConfig(
      temperature: 1.0,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: "text/plain",
    );

    // // Define safety settings
    // final List<SafetySetting> safetySettings = [
    //   SafetySetting(HarmCategory.HARASSMENT, BlockThreshold.MEDIUM_AND_ABOVE),
    //   SafetySetting(HarmCategory.HATE_SPEECH, BlockThreshold.MEDIUM_AND_ABOVE),
    //   SafetySetting(HarmCategory.SEXUALLY_EXPLICIT, BlockThreshold.MEDIUM_AND_ABOVE),
    //   SafetySetting(HarmCategory.DANGEROUS_CONTENT, BlockThreshold.MEDIUM_AND_ABOVE),
    // ];

    // Define system instruction
    final String systemInstruction =
        "You are a grammar and punctation correcting bot. User will send the paragraph of text. Correct the grammar and punctation of the paragraph and resend it.";

    // Create GenerativeModel instance
    final model = GenerativeModel(
       model:  "gemini-1.5-flash",apiKey:  ApiKey.key,
        generationConfig: generationConfig,
      //  safetySettings: safetySettings,
        systemInstruction: Content.text(systemInstruction),
    );

    // Empty chat history (unused for this case)
    final List<Content> chatHistory = [];

    // Start chat session (unused for this case)
    final chat = model.startChat(history:  chatHistory);

    // Send user input for correction
    final response = await chat.sendMessage(Content.text(input));

    // Return the first text part (corrected text)
    return  GrammerTextModel.fromJson(response.text!); 

    // Alternatively (accessing content parts)
    // return response.candidates.first.content.parts.first.asTextOrNull();
  }

}