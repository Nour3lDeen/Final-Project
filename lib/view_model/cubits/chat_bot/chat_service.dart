import 'package:flutter_gemini/flutter_gemini.dart';

class ChatService {
  final gemini = Gemini.instance;

  Future<String> sendMessage(String message) async {
    try {
      const plantInstruction = '''
      You are a specialized bot that ONLY answers questions about plants, gardening, 
      and botany. If asked about other topics, politely decline to answer and 
      remind the user that you specialize in plant-related knowledge.
      
      Plant-related topics include:
      - Plant identification
      - Gardening tips
      - Plant care (watering, sunlight, soil)
      - Plant diseases and treatments
      - Botanical facts
      - Indoor/outdoor plants
      - Plant propagation
      - Edible plants
      ''';

      final response = await gemini.prompt(
        parts: [
          Part.text('$plantInstruction\n\nUser question: $message'),
        ],
      );

      return response?.output ?? 'No response from Gemini about plants.';
    } catch (e) {
      return 'Error processing your plant question: $e';
    }
  }
}