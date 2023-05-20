import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


import '../dataClass/trend.dart';

class githubDetail extends StatefulWidget {
  Trend trend;
  githubDetail({Key? key, required this.trend}) : super(key: key);

  _githubDetail createState() => _githubDetail();
}

class _githubDetail extends State<githubDetail> {
  String repoDes = "";

  String repo = "";
  

  @override
  void initState(){
    super.initState();

    repo = '${widget.trend.userName.toString()} / ${widget.trend.repoName.toString()}';

    ChatGPTRequest(repo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 36, 41, 47),
          foregroundColor: Colors.white,
          title: Text('${widget.trend.repoName.toString()}'),
          centerTitle: true
        ),
        body: Container(
          
          child: Column(
            children: [
              GestureDetector(
                child: Card(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        '$repo 로 이동',
                        style: TextStyle(
                          color: Colors.indigo,
                          decoration: TextDecoration.underline
                        ),
                      )
                    )
                  ),
                  

                ),
                onTap: () async {
                  print(widget.trend.url);
                  await launch(widget.trend.url, forceWebView: true, forceSafariVC: true);
                },
              ),
              


              Card(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/chatgpt-icon.png', width: 30, height: 30, fit: BoxFit.contain,),
                        
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: (repoDes == "")
                            ? Text('입력 중 ...')
                            
                            : Flexible(
                                child: Text('$repoDes')
                              ),
                          ),
                        )
                      ],
                    )
                  ),
                ),
              ),

              
              
            ],
          )
          
          
          
          // Center(child: Text('${trend.star.toString()}'))
        )
    );
  }




  Future<String> ChatGPTRequest(String input) async {

    final apiUrl = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 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'
      },
      body: jsonEncode({
        "messages": [
            {"role": "user", "content": "Significant-Gravitas / Auto-GPT"},
            {"role": "assistant", "content": "Significant-Gravitas/Auto-GPT는 오픈소스로 공개된 GPT-2와 GPT-3 모델을 활용하여 자연어 생성을 수행하는 라이브러리입니다.\n이 라이브러리는 GPT-2 및 GPT-3와 유사한 구조로 구성되어 있으며, 주어진 입력에 대한 응답으로 다양한 유형의 자연어를 생성할 수 있습니다. 또한, 이 라이브러리는 기계 학습을 활용하여 입력 데이터를 분석하고 이를 토대로 자동으로 자연어 생성 모델을 최적화할 수 있습니다.\n이 라이브러리를 사용하면 다양한 분야에서 자연어 처리 작업을 수행할 수 있으며, 예를 들어 챗봇, 문서 요약, 기계 번역, 음성 인식 등 다양한 분야에서 활용할 수 있습니다. 또한, 이 라이브러리는 오픈소스로 공개되어 있어 누구나 자유롭게 사용하고 수정할 수 있습니다."},
            {"role": "user", "content": input}
        ],
        "model": "gpt-3.5-turbo",
        "temperature": 0.2,
        "max_tokens": 1000,
        "stop": "\n"
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
      // final output = responseData['output'];
      
      // String res =  responseData.choices[0].message.content.toString();

      setState(() {
        repoDes = responseData['choices'][0]['message']['content'];
      });

      
      print(responseData['choices'][0]['message']['content']);

      
    } else {
      throw Exception('Failed to communicate with ChatGPT API');
    }


    return "success";
  }
}