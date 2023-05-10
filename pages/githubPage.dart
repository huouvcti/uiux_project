import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import '../dataClass/trend.dart';


class githubPage extends StatefulWidget{
  _githubPageState createState() => _githubPageState();
}

class _githubPageState extends State<githubPage> {
  String result = '';

  List<Trend> trendData = [];

  @override
  void initState() {
    super.initState();

    trendData = new List.empty(growable: true);

    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: trendData!.length == 0
                ? Text("준비중")
                : ListView.builder(
              itemBuilder: (context, position) {
                return GestureDetector(
                  child:  Card(
                    child: Column(
                      children: <Widget>[

                        Text('${trendData![position].userName.toString()}'),

                        Text('${trendData![position].repoName.toString()}'),

                        Text('${trendData![position].url.toString()}'),

                        Text('${trendData![position].language.toString()}'),

                        Text('${trendData![position].star.toString()}'),

                        Text('${trendData![position].fork.toString()}'),

                      ],
                    ),
                  ),

                );
              },
              itemCount: 20),

        ),
      ),
    );
  }



  Future<String> getJSONData() async {
    var url = 'https://github.com/trending?since=monthly';
    var response = await http.get(Uri.parse(url));

    dom.Document document = parser.parse(response.body);


    List<String> userNameList = [];
    List<String> repoNameList = [];
    List<String> urlList = [];
    List<String> languageList = [];
    List<String> starList = [];
    List<String> forkList = [];


    // userName, repoName, url
    document
      .getElementsByClassName('h3 lh-condensed')
      .forEach((dom.Element element) {

        String userName_repoName = element.text.replaceAll(RegExp(r"\s+"), '');

        List<String> userName_repoName_list = userName_repoName.split('/').toList();

        userNameList.add(userName_repoName_list[0]);
        repoNameList.add(userName_repoName_list[1]);

        urlList.add('https://github.com/'+ userName_repoName);
    });

    // language
    document
      .getElementsByClassName('d-inline-block ml-0 mr-3')
      .forEach((dom.Element element) {

        languageList.add(element.text.replaceAll(RegExp(r"\s+"), ''));
    });

    // star, fork
    document
      .getElementsByClassName('Link--muted d-inline-block mr-3')
      .forEachIndexed((index, dom.Element element) {
        if(index%2 == 0){
          starList.add(element.text.replaceAll(RegExp(r"\s+"), ''));
        } else {
          forkList.add(element.text.replaceAll(RegExp(r"\s+"), ''));
        }
      });




    setState(() {
      for (var i=0; i<userNameList.length; i++){
        trendData.add(Trend(
          userName: userNameList[i],
          repoName: repoNameList[i],
          url: urlList[i],
          language: languageList[i],
          star: starList[i],
          fork: forkList[i]
        ));
      }
    });



    return "success";
  }
  
}