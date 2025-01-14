import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CounterStateful extends StatefulWidget {
  Color buttonColor;
  CounterStateful({super.key, required this.buttonColor});

  @override
  State<CounterStateful> createState() {
    State<CounterStateful> stateClassAssociateWithThisWidget =
        _CounterStatefulState();
    return stateClassAssociateWithThisWidget;
  }
}

class _CounterStatefulState extends State<CounterStateful> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
    print(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: widget.buttonColor,
          child: Icon(Icons.add),
          onPressed: () {
            increment();
          },
        ),
        body: Center(
          child: Text(
            '$counter',
            style: TextStyle(fontSize: 30),
          ),
        ));
  }
}
