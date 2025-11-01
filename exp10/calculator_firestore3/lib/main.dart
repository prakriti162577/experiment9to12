import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const CalculatorHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String expression = '';
  String result = '';

  void saveToFirestore(String expression, String result) {
    FirebaseFirestore.instance.collection('history').add({
      'expression': expression,
      'result': result,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      print('✅ Saved to Firestore: $expression = $result');
    }).catchError((error) {
      print('❌ Firestore error: $error');
    });
  }

  void onButtonPressed(String text) {
    setState(() {
      if (text == 'AC') {
        expression = '';
        result = '';
      } else if (text == '=') {
        try {
          final parser = ShuntingYardParser();
          final exp = parser.parse(expression.replaceAll('√', 'sqrt'));
          final resultValue = exp.evaluate(EvaluationType.REAL, ContextModel());
          result = resultValue.toString();
          saveToFirestore(expression, result);
        } catch (e) {
          result = 'Error';
        }
      } else {
        expression += text;
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.deepPurple}) {
    return ElevatedButton(
      onPressed: () => onButtonPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(expression, style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 8),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('/'),
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('*'),
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('-'),
                  buildButton('0'),
                  buildButton('.'),
                  buildButton('AC', color: Colors.red),
                  buildButton('+'),
                  buildButton('√'),
                  buildButton('^'),
                  buildButton('log'),
                  buildButton('='),
                  buildButton('sin'),
                  buildButton('cos'),
                  buildButton('tan'),
                  buildButton('('),
                  buildButton(')'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Widget buildHistoryList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('history')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final expression = data['expression'] ?? '';
            final result = data['result'] ?? '';
            final timestamp = data['timestamp']?.toDate().toString() ?? '';

            return ListTile(
              title: Text('$expression = $result'),
              subtitle: Text(timestamp),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculation History')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: buildHistoryList(),
      ),
    );
  }
}