import 'package:flutter/material.dart';

import '../dataClass/trend.dart';

class githubDetail extends StatelessWidget {
  Trend trend;

  githubDetail({Key? key, required this.trend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Container(child: Center(child: Text('${trend.star.toString()}'))));
  }
}
