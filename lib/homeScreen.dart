import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt("counter") ?? 0;
    });
  }

  void _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("counter", _counter);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _saveCounter();
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter < 0) {
        _counter = 0;
      }
      ;
    });
    _saveCounter();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    _saveCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WaterCounter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Anzahl der Getränke"),
            Text(
              "$_counter",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text("Trinken"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: _decrementCounter,
                    child: Text("Getränk entfernen")),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: _resetCounter,
                    child: Text("Zähler zurücksetzen"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
