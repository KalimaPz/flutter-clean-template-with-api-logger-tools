import 'package:arainii_app_template/api_services.dart';
import 'package:arainii_app_template/components/alert.dart';
import 'package:arainii_app_template/components/sx_button.dart';
import 'package:arainii_app_template/utils/log_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  Alert alert = Alert();

  void _incrementCounter() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LogView(),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SxButton(
              child: Text("DIALOG 1"),
              onTap: () {
                alert.show(context,
                    title: "ทดสอบ", desc: "This is Spacex Dialog UI");
              },
            ),
            SxButton(
              child: Text("DIALOG 2"),
              onTap: () {
                alert.show(context, okOnly: true);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
