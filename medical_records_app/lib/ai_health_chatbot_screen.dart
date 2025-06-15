import 'package:flutter/material.dart';

class AiHealthChatbotScreen extends StatelessWidget {
  const AiHealthChatbotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Health Chatbot'),
      ),
      body: const Center(
        child: Text('Welcome to the AI Health Chatbot!'),
      ),
    );
  }
}
