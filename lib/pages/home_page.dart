import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Initialize the Gemini Developer API backend service
            // Create a `GenerativeModel` instance with a model that supports your use case
            final model = FirebaseAI.googleAI().generativeModel(
              model: 'gemini-2.5-flash',
            );

            // Provide a prompt that contains text
            final prompt = [
              Content.text('Write a story about a magic backpack.'),
            ];

            // To generate text output, call generateContent with the text input
            final response = await model.generateContent(prompt);
            print(response.text);
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}
