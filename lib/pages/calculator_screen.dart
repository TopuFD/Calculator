

import 'package:calculator_app/pages/button_valuse.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var number1 = "";
  var oparend = "";
  var number2 = "";
  @override
  Widget build(BuildContext context) {
    final buttonSized = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "$number1$oparend$number2".isEmpty
                        ? "0"
                        : "$number1$oparend$number2",
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            //buttons

            Wrap(
              children: Btn.buttonValuse
                  .map(
                    (value) => SizedBox(
                      width: value == Btn.n0
                          ? buttonSized.width / 2
                          : buttonSized.width / 4,
                      height: buttonSized.height / 9,
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

//###########
  onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    } else if (value == Btn.clr) {
      clearAll();
      return;
    } else if (value == Btn.par) {
      converterParcentage();
      return;
    } else if (value == Btn.sum) {
      calculation();
      return;
    }
    appedValues(value);
  }

  //###########
  calculation() {
    if (number1.isEmpty || oparend.isEmpty || number2.isEmpty) {
      return;
    } else {
      final num1 = double.parse(number1);
      final num2 = double.parse(number2);
      var result;
      switch (oparend) {
        case Btn.devide:
          result = num1 / num2;
          break;
        case Btn.multiply:
          result = num1 * num2;
          break;
        case Btn.add:
          result = num1 + num2;
          break;
        case Btn.substract:
          result = num1 - num2;
          break;
        default:
      }
      setState(() {
        number1 = result.toString();
        number1 = number1.substring(0, number1.length - 2);
        oparend = "";
        number2 = "";
      });
    }
  }

  //###########
  void converterParcentage() {
    final number = double.parse(number1);
    setState(() {
      number1 = "${number / 100}";
      oparend = "";
      number2 = "";
    });
  }

  //##########
  void clearAll() {
    number1 = "";
    oparend = "";
    number2 = "";
    setState(() {});
  }

  //##########
  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (oparend.isNotEmpty) {
      oparend = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  //#########
  void appedValues(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (oparend.isNotEmpty && number2.isNotEmpty) {}
      oparend = value;
    } else if (number1.isEmpty || oparend.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        value = "0.";
      }
      number1 += value;
    } else if (number2.isEmpty || oparend.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        value = "0.";
      }
      number2 += value;
    }
    setState(() {});
  }

//###########
  getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [Btn.devide, Btn.multiply, Btn.add, Btn.substract, Btn.sum, Btn.par]
                .contains(value)
            ? Colors.orange
            : Colors.black87;
  }
}
