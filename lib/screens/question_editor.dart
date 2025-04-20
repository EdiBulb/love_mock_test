import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/quiz_data.dart';

class QuestionEditor extends StatefulWidget {
  const QuestionEditor({super.key});

  @override
  State<QuestionEditor> createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  final TextEditingController _questionController = TextEditingController();
  bool _answer = true;
  int? _editingIndex;

  void _addOrUpdateQuestion() {
    final text = _questionController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (_editingIndex == null) {
        globalQuestionList.add(Question(text, _answer));
      } else {
        globalQuestionList[_editingIndex!] = Question(text, _answer);
        _editingIndex = null;
      }

      _questionController.clear();
      _answer = true;
    });
  }

  void _editQuestion(int index) {
    setState(() {
      _questionController.text = globalQuestionList[index].questionText;
      _answer = globalQuestionList[index].questionAnswer;
      _editingIndex = index;
    });
  }

  void _deleteQuestion(int index) {
    setState(() {
      globalQuestionList.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = null;
        _questionController.clear();
        _answer = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Quiz Questions")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: "Enter question"),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Answer is: "),
                DropdownButton<bool>(
                  value: _answer,
                  items: const [
                    DropdownMenuItem(value: true, child: Text("True")),
                    DropdownMenuItem(value: false, child: Text("False")),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _answer = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addOrUpdateQuestion,
              child: Text(_editingIndex == null ? "Add Question" : "Update Question"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: globalQuestionList.length,
                itemBuilder: (context, index) {
                  final question = globalQuestionList[index];
                  return Card(
                    child: ListTile(
                      title: Text(question.questionText),
                      subtitle: Text("Answer: ${question.questionAnswer ? 'True' : 'False'}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editQuestion(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteQuestion(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
