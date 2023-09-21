//import 'package:flutter/src/foundation/key.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mysql/info_nhanvien.dart';
//import 'package:flutter/src/widgets/framework.dart';

import 'app_path.dart';
import 'mainmenu.dart';
import 'package:http/http.dart' as http;

class ThongKePage extends StatefulWidget {
  const ThongKePage({Key? key}) : super(key: key);

  @override
  State<ThongKePage> createState() => _ThongKePageState();
}

class _ThongKePageState extends State<ThongKePage> {
  Future<List> getDataNhanVien() async {
    //var uri = Uri.parse("http://192.168.4.75/flutter_mysql/getdata.php");
    var uri = Uri.parse(AppPath.getNhanVienPath);
    //final response = await http.get(uri);
    var response = await http.get(uri);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống kê nhật ký"),
        actions: const [
          MainMenu(),
        ],
      ),
      body: FutureBuilder<List>(
        future: getDataNhanVien(),
        builder: (context, snapshot) {
          //return RefreshIndicator(child: list, onRefresh: onRefresh);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return
                //Text(snapshot.data);
                ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        alignment: Alignment.topLeft,
                                        //color: Colors.grey,
                                        child: Text(
                                          snapshot.data![index]['hoten'],
                                          style: const TextStyle(fontSize: 20),
                                        )),
                                  ],
                                ))),
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (BuildContext context) => InFoNhanVien(
                                    list: snapshot.data!, index: index)))
                            .then((value) {
                          getDataNhanVien();
                          setState(() {
                            getDataNhanVien();
                          });
                        }),
                      );
                    });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
