import 'package:flutter/material.dart';
import 'package:flutter_mysql/app_path.dart';
import 'package:flutter_mysql/editdata.dart';
import 'package:flutter_mysql/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'adddata.dart';
import 'mainmenu.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MySQL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      ///home: const MyHomePage(title: 'Flutter MySQL'),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;
  final String user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences logindata;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    getData();
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<List> getData() async {
    var uri = Uri.parse(AppPath.getNhatkyPath);
    var response = await http.post(uri, body: {"username": widget.user});

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [
          MainMenu(),
        ],
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          //return RefreshIndicator(child: list, onRefresh: onRefresh);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return
                //Text(snapshot.data);
                SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              onRefresh: _onRefresh,
              //onRefresh: getData,
              //onLoading: _onLoading,
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        extentRatio: 0.85,
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              //print(snapshot.data![index]['noidungcv1']);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AddData(
                                    user: widget.user,
                                    cv1: snapshot.data![index]['noidungcv1'],
                                    cv2: snapshot.data![index]['noidungcv2'],
                                  ),
                                ),
                              );
                            },
                            flex: 2,
                            backgroundColor: const Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.copy,
                            label: 'Coppy',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Card(
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.green, width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            shadowColor: Colors.blueGrey,
                            elevation: 5,
                            child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12))),
                                        alignment: Alignment.topLeft,
                                        //color: Colors.grey,
                                        child: Text(
                                          snapshot.data![index]['ngaynk'],
                                          style: const TextStyle(fontSize: 20),
                                        )),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data![index]['noidungcv1'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data![index]['noidungcv2'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ))),
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (BuildContext context) => EditData(
                                    list: snapshot.data!, index: index)))
                            .then((value) async {
                          await getData();
                          setState(() {});
                        }),
                      ),
                    );
                  }),
            );
          } else {
            return Container();
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (BuildContext context) => AddData(
              user: widget.user,
              cv1: '',
              cv2: '',
            ),
          ),
        )
            .then((value) {
          setState(() {});
        }),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
