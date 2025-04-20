import 'package:flutter/material.dart';

class QuestionEditor extends StatefulWidget {
  const QuestionEditor({super.key});

  @override
  State<QuestionEditor> createState() => _QuestionEditorState();
}

class _QuestionEditorState extends State<QuestionEditor> {
  final TextEditingController _questionController = TextEditingController();
  bool _answer = true;

  List<Map<String, dynamic>> _questionList = [];

  void _addQuestion() {
    if (_questionController.text.trim().isEmpty) return;

    setState(() {
      _questionList.add({
        'text': _questionController.text.trim(),
        'answer': _answer,
      });
      _questionController.clear();
      _answer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Quiz Question")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 문제 입력
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: "Enter question"),
            ),
            const SizedBox(height: 10),

            // 정답 선택 (Toggle)
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
              onPressed: _addQuestion,
              child: const Text("Add Question"),
            ),

            const SizedBox(height: 20),

            // 질문 리스트 미리 보기
            Expanded(
              child: ListView.builder(
                itemCount: _questionList.length,
                itemBuilder: (context, index) {
                  final question = _questionList[index];
                  return ListTile(
                    title: Text(question['text']),
                    subtitle: Text(
                        "Answer: ${question['answer'] ? "True" : "False"}"),
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
