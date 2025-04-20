import 'package:flutter/material.dart';
import 'screens/role_select_page.dart';
import 'screens/quiz_page.dart';
import 'screens/question_editor.dart';
import 'screens/result_page.dart';
import 'screens/name_input_page.dart';

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler App',
      debugShowCheckedModeBanner: false,
      home: const RoleSelectPage(),
      routes: {
        '/editor': (context) => const QuestionEditor(),
        '/guest': (context) => const NameInputPage(), // 👤 이름 입력용

      },
    );
  }
}
