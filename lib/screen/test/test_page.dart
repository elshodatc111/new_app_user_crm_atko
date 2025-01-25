import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<Map<String, dynamic>> queth = [
    {
      "Savol": "1.O'zbekiston poytaxti qayer",
      "Javob": [
        {"test": "Qarshi", "status": false},
        {"test": "Buxoro", "status": false},
        {"test": "Toshkent", "status": true},
        {"test": "Xorazm", "status": false},
      ]
    },
    {
      "Savol": "2.Qashqadaryo viloyati",
      "Javob": [
        {"test": "Qarshi", "status": true},
        {"test": "Samarqand", "status": false},
        {"test": "Guliston", "status": false},
        {"test": "Termiz", "status": false},
      ]
    },
    {
      "Savol": "3.Surxondaryo viloyati markaziy shaxri qayer",
      "Javob": [
        {"test": "Qarshi", "status": false},
        {"test": "Samarqand", "status": false},
        {"test": "Guliston", "status": false},
        {"test": "Termiz", "status": true},
      ]
    },
  ];
  int count = 0;
  int answer = 0;

  void asnwerQuetion(bool status) {
    setState(() {
      count++;
      if (status) {
        answer = answer + 1;
      }
      print(answer);
    });
  }

  void resset() {
    setState(() {
      count = 0;
      answer = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(answer);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Testlar",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff0961F5),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              "${count + 1} / ${queth.length}",
              style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: count < queth.length
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    queth[count]['Savol'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff202244),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: TextButton(
                      onPressed: () =>
                          asnwerQuetion(queth[count]['Javob'][0]['status']),
                      child: Text(
                        queth[count]['Javob'][0]['test'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: TextButton(
                      onPressed: () =>
                          asnwerQuetion(queth[count]['Javob'][1]['status']),
                      child: Text(
                        queth[count]['Javob'][1]['test'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: TextButton(
                      onPressed: () =>
                          asnwerQuetion(queth[count]['Javob'][2]['status']),
                      child: Text(
                        queth[count]['Javob'][2]['test'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: TextButton(
                      onPressed: () =>
                          asnwerQuetion(queth[count]['Javob'][3]['status']),
                      child: Text(
                        queth[count]['Javob'][3]['test'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Natija $answer/${queth.length}\nBall:${answer * 5} ball",
                  ),
                  ElevatedButton.icon(
                    onPressed: resset,
                    label: Text("RESSET"),
                    icon: Icon(Icons.restart_alt_sharp),
                  ),
                ],
              )),
      ),
    );
  }
}
