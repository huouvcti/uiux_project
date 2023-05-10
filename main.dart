import 'package:flutter/material.dart';
import 'pages/githubPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listview Example'),
        ),
        body: TabBarView(
          children: <Widget>[
            Text(''),
            githubPage(),
            Text(''),
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(tabs: <Tab>[
            Tab(icon: Icon(Icons.home, color: Colors.blue),) ,
            Tab(icon: Icon(Icons.trending_up, color: Colors.blue),),
            Tab(icon: Icon(Icons.newspaper, color: Colors.blue),)
          ], controller: controller,
        )
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}