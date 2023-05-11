import 'package:flutter/material.dart';
import 'pages/githubPage.dart';


import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';


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
  // TabController? controller;

  MotionTabController? _tabController;

  @override
  void initState() {
    super.initState();
    // controller = TabController(length: 3, vsync: this);

    _tabController = new MotionTabController(initialIndex:1,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Listview Example'),
        // ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget> [
            Text(''),
            githubPage(),
            Text(''),
          ],
        ),
        
        // TabBarView(
        //   children: <Widget>[
        //     Text(''),
        //     githubPage(),
        //     Text(''),
        //   ],
        //   controller: controller,
        // ),

        bottomNavigationBar: MotionTabBar(
          labels: [
            "Home", "Trend", "News"
          ],
          initialSelectedTab: "Home",
          tabIconColor: Color.fromARGB(255, 36, 41, 47),
          tabSelectedColor: Color.fromARGB(255, 36, 41, 47),
          onTabItemSelected: (int value){
            setState(() {
              _tabController!.index = value;
            });
          },
          icons: [
            Icons.home,
            Icons.trending_up,
            Icons.newspaper,
          ],
          textStyle: TextStyle(color: Color.fromARGB(255, 36, 41, 47)),
        ),

        // bottomNavigationBar: TabBar(tabs: <Tab>[
        //     Tab(icon: Icon(Icons.home, color: Colors.blue),) ,
        //     Tab(icon: Icon(Icons.trending_up, color: Colors.blue),),
        //     Tab(icon: Icon(Icons.newspaper, color: Colors.blue),)
        //   ], controller: controller,
        // )
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}