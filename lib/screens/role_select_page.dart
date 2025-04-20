import 'package:flutter/material.dart';

class RoleSelectPage extends StatelessWidget {
  const RoleSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select User Role")),
      backgroundColor: Colors.grey.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editor');
                },
              child: const Text("I'm Admin"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/guest');
            },
            child: const Text("I'm Guest"),
            ),
          ],
        ),
      ),
    );
  }
}
