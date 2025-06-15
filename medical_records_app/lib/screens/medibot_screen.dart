import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedibotScreen extends StatefulWidget {
  const MedibotScreen({super.key});
  
  @override
  State<MedibotScreen> createState() => _MedibotScreenState();
}

class _MedibotScreenState extends State<MedibotScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  final List<String> _quickPrompts = [
    "I have a headache",
    "Check my symptoms",
    "Suggest a diet",
    "Show mental health tips",
  ];

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _controller.clear();
      _isTyping = true;
    });

    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer [YOUR_API_KEY]',
        },
        body: json.encode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a helpful medical assistant named MediBot."},
            ..._messages.map((m) => {
              "role": m['role'],
              "content": m['text'],
            }),
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final reply = data['choices'][0]['message']['content'];

        setState(() {
          _messages.add({'role': 'bot', 'text': reply.trim()});
          _isTyping = false;
        });
      } else {
        final error = json.decode(response.body);
        setState(() {
          _messages.add({
            'role': 'bot',
            'text': 'Error ${response.statusCode}: ${error['error']['message'] ?? 'Unknown error.'}',
          });
          _isTyping = false;
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({'role': 'bot', 'text': 'Exception: $e'});
        _isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask MediBot'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Wrap(
              spacing: 8,
              children: _quickPrompts.map((prompt) {
                return ElevatedButton(
                  onPressed: () => _sendMessage(prompt),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[100],
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(prompt),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.teal[200] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text("MediBot is typing...", style: TextStyle(color: Colors.grey)),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.teal),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
