import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import '../dataClass/news.dart';

class newsPage extends StatefulWidget {
  _newsPageState createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  String result = '';

  List<News> newsData = new List.empty(growable: true);


  @override
  void initState() {
    super.initState();

    newsData = [];
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 18, 53, 119),
            // title: Text("ddddddddd"),
            elevation: 0.0,
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(children: [
              Container(
                  height: 200,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                            child: Text(
                              "IT/과학 News",
                              style: TextStyle(fontSize: 30, color: Colors.white),
                            )),
                      ),
                    ],
                  )),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 246, 248, 250),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Center(
                    child: newsData!.length == 0
                        ? Text("준비중")
                        : ListView.builder(
                        itemBuilder: (context, position) {
                          return GestureDetector(
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(0),

                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text('${newsData![position].title}')
                                )

                                // child: Column(
                                //   children: [
                                //     Text('${newsData![position].title.toString()}', maxLines: 1,),
                                //     Text('${newsData![position].content.toString()}', maxLines: 2),
                                //   ],
                                // )


                              )




                            ),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => githubDetail(
                              //             trend: trendData![position])));
                            },
                          );
                        },
                        itemCount: newsData!.length),
                  ),
                ),
              )
            ])));
  }

  Future<String> getJSONData() async {
    var url = 'https://www.bloter.net/news/articleList.html?sc_section_code=S1N4&view_type=sm';
    var response = await http.get(Uri.parse(url));

    dom.Document document = parser.parse(response.body);

    List<String> imgUrlList = [];
    List<String> titleList = [];
    List<String> contentList = [];

    newsData.clear();

    document.getElementsByClassName('thumb')
        .forEach((dom.Element element) {
      dom.Element imgTag = element.getElementsByTagName('img')[0];
      String imgUrl = imgTag.attributes['src'].toString();
      imgUrlList.add(imgUrl!);
    });

    document.getElementsByClassName('titles')
        .forEach((dom.Element element) {
      String title = element.text;
      titleList.add(title);
    });

    titleList.removeAt(0);

    document.getElementsByClassName('lead line-6x2')
        .forEach((dom.Element element) {
      String content = element.text;
      contentList.add(content);
    });


    setState(() {
      for (var i = 0; i < imgUrlList.length; i++) {
        newsData.add(News(
            imgUrl: imgUrlList[i],
            title: titleList[i],
            content: contentList[i],
        ));
      }

      newsData.removeLast();
    });

    return "success";
  }
}