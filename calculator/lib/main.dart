import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50.0,
            title: Text('My Calculator'),
            backgroundColor: Colors.black,
            brightness: Brightness.dark,
          ),
          body: CalculationScreen(),
        ));
  }
}

class CalculationScreen extends StatefulWidget {
  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  // variable to define list of possible buttons
  final List<String> listOfButtons = [
    'C',
    'Del',
    '÷',
    'x',
    '+',
    '-',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '='
  ];

  // variables for storing input and answers
  var userInput = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // screens with final result and input
        //

        // button placement
        Expanded(
            child: GridView.builder(
                itemCount: listOfButtons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 2.5),
                itemBuilder: (BuildContext context, i) {
                  return Container(
                      child: IconButton(
                    icon: Text(listOfButtons[i],
                        style: TextStyle(fontSize: 25.0, color: Colors.black)),
                    onPressed: () {
                      // Clear
                      if (i == 0) {
                        setState(() {
                          userInput = '';
                        });
                      } else if (i == 2 || i == 3 || i == 4 || i == 5) {
                        if (userInput != '') {
                          setState(() {
                            userInput += listOfButtons[i];
                          });
                        }
                      }
                      // Equals button
                      else if (i == 16 && userInput != '') {
                        setState(() {
                          Parser p = new Parser();
                          Expression expression = p.parse(userInput);
                          answer = expression
                              .evaluate(EvaluationType.REAL, null)
                              .toString();
                        });
                      }

                      // Numbers
                      else {
                        setState(() {
                          userInput += listOfButtons[i];
                        });
                      }
                    },
                  ));
                }))
      ],
    );
  }
}
