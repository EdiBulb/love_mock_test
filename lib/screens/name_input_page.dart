import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';
import 'quiz_page.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({super.key});

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final TextEditingController _nameController = TextEditingController();

  void _startQuiz() {
    final name = _nameController.text.trim();
    if (name.isEmpty || globalQuestionList.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          guestName: name,
          questions: globalQuestionList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter your name")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startQuiz,
              child: const Text("Start Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
