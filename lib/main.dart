import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    
    void showSnackBar(String text, String ans) {
      final SnackBar snackBar = SnackBar(
        duration: const Duration(milliseconds: 500),
        backgroundColor: ans.compareTo('Yes') == 0 ? Colors.green : Colors.red,
        content: Row(
          children: <Widget>[
            Icon(
              ans.compareTo('Yes') == 0 ? Icons.favorite : Icons.watch_later,
              color: ans.compareTo('Yes') == 0 ? Colors.blue : Colors.grey,
              size: 24,
              semanticLabel: text,
            ),
            Text(text)
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Future<void> cupertinoDialog() async {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Welcome'),
              content: const Text("Cupertino Dialog. Is it nice?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, "Yes");
                  }, 
                  child: const Text('Yes'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, 'No');
                  },
                  child: const Text('No'),
                ),
              ],
            );
          })) {
        case 'Yes':
          showSnackBar('Thanks!', 'Yes');
          break;
        case 'No':
          showSnackBar('Ok!', 'Sorry');
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Scaffold'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_alert),
          tooltip: 'Show Snackar',
          onPressed: () {},
        ),
        IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Close',
            onPressed: () {
              Navigator.pop(context);
            })
      ]),
      body: Center(
        child: TextButton(
          onPressed: cupertinoDialog, 
          child: const Text('Cupertino Dialog')),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Theme.of(context).primaryColor,
          child: Container(
            height: 50,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          count++;
        }),
        tooltip: 'Increment counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
