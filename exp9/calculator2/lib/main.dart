import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'database_helper.dart';

void main() => runApp(const CalculatorApp());

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
  List<Map<String, dynamic>> history = [];

  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await dbHelper.getHistory();
    setState(() {
      history = data;
    });
  }

  Future<void> clearHistory() async {
    final db = await dbHelper.db;
    await db.delete('history');
    loadHistory();
  }

  void onButtonPressed(String text) async {
    if (text == 'AC') {
      setState(() {
        expression = '';
        result = '';
      });
    } else if (text == '=') {
      try {
        final parser = ShuntingYardParser();
        final exp = parser.parse(expression.replaceAll('√', 'sqrt'));
        final cm = ContextModel();
        final eval = exp.evaluate(EvaluationType.REAL, cm);
        final res = eval.toString();

        await dbHelper.insertHistory(expression, res);
        final data = await dbHelper.getHistory();

        setState(() {
          result = res;
        });
        setState(() {
          history = data;
        });
      } catch (e) {
        setState(() {
          result = 'Error';
        });
      }
    } else {
      setState(() {
        expression += text;
      });
    }
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
      appBar: AppBar(title: const Text('Calculator')),
      body: SingleChildScrollView( // ✅ Added scroll wrapper
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container( // ✅ Removed Expanded to avoid overflow
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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: clearHistory,
                    child: const Text(
                      'Clear History',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return ListTile(
                      title: Text(item['expression']),
                      subtitle: Text('= ${item['result']}'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // ✅ Prevent nested scroll conflict
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
            ],
          ),
        ),
      ),
    );
  }
}