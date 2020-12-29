import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_project/model/listdata.dart';
import 'package:test_project/service/list_data_service.dart';

class HomePage extends StatefulWidget {
  final ListData projectHomePage;
  HomePage({this.projectHomePage});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //color: Colors.blue,
              height: MediaQuery.of(context).size.height,
              child: Container(
                //color: Colors.red,
                height: MediaQuery.of(context).size.height / 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 40,
                  ),
                  child: FutureBuilder(
                    future: _getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.done:
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text('Loading'),
                              ),
                            );
                          } else {
                            listData = snapshot.data;
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              //scrollDirection: Axis.horizontal,
                              itemCount: listData.length,
                              itemBuilder: (BuildContext context, int index) {
                                ListData listDatas = listData[index];
                                return Card(
                                  elevation: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          width: 2.0,
                                        ),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(7),
                                      child: Stack(children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Stack(
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 5),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(listDatas.id
                                                          .toString()),
                                                      Text(listDatas.userId
                                                          .toString()),
                                                      Text(listDatas.title),
                                                      Text(listDatas.body)
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          break;
                        case ConnectionState.active:
                          return Container(
                            child: Center(
                              child: Text('loading'),
                            ),
                          );
                          break;
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ListData> listData = [];

  Future<List<ListData>> _getData() async {
    // final prefs = await SharedPreferences.getInstance();

    var res = await ListDataSrvice().doData();
    // print(res.body);
    var jsondata = json.decode(res.body);
    List<ListData> listData = [];
    for (var m in jsondata) {
      ListData listDatas = ListData(
          id: m["id"], userId: m["userId"], title: m["title"], body: m["body"]);
      listData.add(listDatas);
    }
    // await new Future.delayed(new Duration(seconds: 3));
    return listData;
  }
}
