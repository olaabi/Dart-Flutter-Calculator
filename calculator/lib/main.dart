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
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '=',
    '0',
    'C',
    '/',
    'DEL',
    'ANS',
    'AC',
    '.'
  ];

  // variables for storing input and answers
  var userInput = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // screens with final result and input
        Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(7),
            alignment: Alignment.centerRight,
            child: Column(
              children: <Widget>[
                Text(
                  userInput,
                  style: TextStyle(color: Colors.black54, fontSize: 30.0),
                  textAlign: TextAlign.right,
                ),
              ],
            )),
        Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerRight,
            child: Column(
              children: <Widget>[
                Text(answer,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 30.0),
                    textAlign: TextAlign.right),
              ],
            )),

        Divider(
          color: Colors.black,
          thickness: 5.0,
          height: 5.0,
        ),

        // button placement
        Expanded(
            child: GridView.builder(
                itemCount: listOfButtons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 0.0),
                itemBuilder: (BuildContext context, i) {
                  return Container(
                      height: 10.0,
                      decoration: BoxDecoration(
                          color:
                              (i == 12) ? Colors.blue.shade100 : Colors.white,
                          border: Border.all(color: Colors.blueGrey.shade700)),
                      child: IconButton(
                        icon: Text(listOfButtons[i],
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.black)),
                        onPressed: () {
                          // Clear
                          if (i == 14) {
                            setState(() {
                              userInput = '';
                            });

                            // Operators
                          } else if (i == 3 ||
                              i == 7 ||
                              i == 11 ||
                              i == 15 ||
                              i == 19) {
                            String lastChar = userInput.substring(
                                userInput.length - 1, userInput.length);
                            if (userInput != '' &&
                                lastChar != listOfButtons[3] &&
                                lastChar != listOfButtons[7] &&
                                lastChar != listOfButtons[11] &&
                                lastChar != listOfButtons[15] &&
                                lastChar != listOfButtons[19]) {
                              setState(() {
                                userInput += listOfButtons[i];
                              });
                            }
                          }
                          // Equals button
                          else if (i == 12 && userInput != '') {
                            setState(() {
                              Parser p = new Parser();
                              Expression expression = p.parse(userInput);
                              answer = expression
                                  .evaluate(EvaluationType.REAL, null)
                                  .toString();
                            });
                          }

                          // Answer memory
                          else if (i == 17) {
                            if (answer != '') {
                              setState(() {
                                userInput += answer;
                              });
                            }

                            // All clear (clears answer and user input)
                          } else if (i == 18) {
                            setState(() {
                              userInput = '';
                              answer = '';
                            });

                            // Deletes last digit/symbol
                          } else if (i == 16) {
                            if (userInput != '') {
                              setState(() {
                                userInput = userInput.substring(
                                    0, userInput.length - 1);
                              });
                            }
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
