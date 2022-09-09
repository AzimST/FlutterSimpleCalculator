import 'package:calculate/product/projectUtility.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorSimple extends StatefulWidget {
  const CalculatorSimple({super.key});

  @override
  State<CalculatorSimple> createState() => _CalculatorSimpleState();
}

class _CalculatorSimpleState extends State<CalculatorSimple> {
  var usersInput = "";
  var answer = "";

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(
            color: ProjectColorUtility().blue1,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: ProjectColorUtility().blue9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topCenter,
                    child: Text(
                      textAlign: TextAlign.start,
                      usersInput,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topCenter,
                    child: Text(
                      answer,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: GridView.builder(
                physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // clear button
                  if (index == 0) {
                    return _myButton2(
                      title: buttons[index],
                      TextColor: ProjectColorUtility().blue1,
                      color: ProjectColorUtility().blue4,
                      buttontapped: () {
                        setState(
                          () {
                            usersInput = "";
                            answer = "0";
                          },
                        );
                      },
                    );
                  }
                  // +/- Button
                  else if (index == 1) {
                    return _myButton2(
                      TextColor: ProjectColorUtility().blue7,
                      color: ProjectColorUtility().blue3,
                      title: buttons[index],
                    );
                  }
                  // % button
                  else if (index == 2) {
                    return _myButton2(
                        TextColor: ProjectColorUtility().blue7,
                        color: ProjectColorUtility().blue3,
                        title: buttons[index]);
                  }
                  // delete button
                  else if (index == 3) {
                    return _myButton2(
                      TextColor: ProjectColorUtility().blue1,
                      color: ProjectColorUtility().blue4,
                      title: buttons[index],
                      buttontapped: () {
                        setState(() {
                          usersInput =
                              usersInput.substring(0, usersInput.length - 1);
                        });
                      },
                    );
                  }
                  // equal to button
                  else if (index == 18) {
                    return _myButton2(
                      TextColor: Color(0xffffc300),
                      color: ProjectColorUtility().blue2,
                      title: buttons[index],
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                    );
                  } else {
                    return _myButton2(
                      TextColor: isOperator(buttons[index])
                          ? ProjectColorUtility().blue4
                          : ProjectColorUtility().blue3,
                      color: isOperator(buttons[index])
                          ? ProjectColorUtility().blue6
                          : ProjectColorUtility().blue7,
                      title: buttons[index],
                      buttontapped: () {
                        setState(() {
                          usersInput += buttons[index];
                        });
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "/" || x == "x" || x == "-" || x == "+" || x == "=") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalUserinput = usersInput;
    finalUserinput = usersInput.replaceAll("x", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalUserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

class _myButton extends StatelessWidget {
  const _myButton({
    Key? key,
    required this.TextColor,
    this.buttontapped,
    required this.color,
    required this.title,
  }) : super(key: key);

  final String title;
  final Color color;
  final Color TextColor;
  final buttontapped;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttontapped,
      child: Text(title),
    );
  }
}

class _myButton2 extends StatelessWidget {
  const _myButton2({
    super.key,
    required this.title,
    required this.color,
    required this.TextColor,
    this.buttontapped,
  });
  final String title;
  final Color color;
  final Color TextColor;
  final buttontapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: ClipRRect(
        child: Padding(
          padding: const EdgeInsets.all(.5),
          child: Container(
            color: color,
            child: Center(
                child: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            )),
          ),
        ),
      ),
    );
  }
}
