import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GeminiDataSource {
  Future<String> generateInsight(String prompt);
}

@LazySingleton(as: GeminiDataSource)
class GeminiDataSourceImpl implements GeminiDataSource {
  final SharedPreferences sharedPreferences;

  GeminiDataSourceImpl(this.sharedPreferences);

  @override
  Future<String> generateInsight(String prompt) async {
    final apiKey = sharedPreferences.getString('gemini_api_key');
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API Key not found. Please add your Gemini API Key in Settings.');
    }

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    
    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      return response.text ?? 'No insight generated.';
    } catch (e) {
      throw Exception('Failed to generate insight: $e');
    }
  }
}
