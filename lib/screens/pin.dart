import 'dart:developer';

import 'package:flutter/material.dart';

class PinPage extends StatefulWidget {
  final int digit;
  final Color activeColor;
  final Color inactiveColor;
  const PinPage({
    super.key,
    this.digit = 6,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String pin = "";
  InkWell numpad(String value) {
    return InkWell(
      onTap: () {
        if (value == "Del") {
          if (pin.isNotEmpty) {
            setState(() {
              colors[pin.length - 1] = widget.inactiveColor;
              pin = pin.substring(0, pin.length - 1);
            });
          }
        } else {
          if (pin.length < widget.digit) {
            setState(() {
              colors[pin.length] = widget.activeColor;
              pin += value;
            });

            if (widget.digit == pin.length) {
              log('on submit');
              // setState(() {
              //   colors = List.generate(
              //       widget.digit, (index) => widget.inactiveColor);
              //   pin = "";
              // });
            }
          }
        }
      },
      child: Container(
        // color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  late List<Color> colors;
  @override
  void initState() {
    super.initState();

    colors = List.generate(widget.digit, (index) => widget.inactiveColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('My App'),
                )),
            Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ใส่รหัส PIN ${widget.digit} หลัก',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('เพื่อเข้าใช้งาน',
                        style: TextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          widget.digit,
                          (index) => Container(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: colors[index],
                                ),
                              )),
                    ),
                  ],
                )),
                Container(
                  // decoration: BoxDecoration(color: widget.inactiveColor[200]),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    children: [
                      numpad("1"),
                      numpad("2"),
                      numpad("3"),
                      numpad("4"),
                      numpad("5"),
                      numpad("6"),
                      numpad("7"),
                      numpad("8"),
                      numpad("9"),
                      numpad(">"),
                      numpad("0"),
                      numpad("Del"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
