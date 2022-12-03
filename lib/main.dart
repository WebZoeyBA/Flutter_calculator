import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WebZoeyBA Calculator",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: ZoeyCalculator(),
    );
  }
}

class ZoeyCalculator extends StatefulWidget {
  const ZoeyCalculator({super.key});

  @override
  State<ZoeyCalculator> createState() => _ZoeyCalculatorState();
}

class _ZoeyCalculatorState extends State<ZoeyCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "del") {
        equation = equation.substring(0, equation.length - 1);
        if (equation.length == 0) {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebZoeyBA calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("del", 1, Colors.blueGrey),
                        buildButton("%", 1, Colors.blueGrey),
                        buildButton("÷", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.grey),
                        buildButton("8", 1, Colors.grey),
                        buildButton("9", 1, Colors.grey),
                        buildButton("x", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.grey),
                        buildButton("5", 1, Colors.grey),
                        buildButton("6", 1, Colors.grey),
                        buildButton("-", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.grey),
                        buildButton("2", 1, Colors.grey),
                        buildButton("3", 1, Colors.grey),
                        buildButton("+", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(",", 1, Colors.grey),
                        buildButton("0", 1, Colors.grey),
                        buildButton("00", 1, Colors.grey),
                        buildButton("=", 1, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
