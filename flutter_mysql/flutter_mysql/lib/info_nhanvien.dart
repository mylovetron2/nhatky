import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mysql/app_path.dart';
import 'package:http/http.dart' as http;

class InFoNhanVien extends StatefulWidget {
  const InFoNhanVien({Key? key, required this.list, required this.index})
      : super(key: key);
  final List list;
  final int index;

  @override
  _InFoNhanVienState createState() => _InFoNhanVienState();
}

class _InFoNhanVienState extends State<InFoNhanVien> {
  //TextEditingController stt = TextEditingController();
  String hoten = '';

  Future<List> infonhanvien() async {
    var uri = Uri.parse(AppPath.infoNhanVienPath);
    //final response = await http.get(uri);
    var response = await http.post(uri, body: {"hoten": hoten});
    return json.decode(response.body);
  }

  @override
  void initState() {
    hoten = widget.list[widget.index]['hoten'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhật ký"),
      ),
      body: FutureBuilder<List>(
        future: infonhanvien(),
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
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12))),
                                        alignment: Alignment.topLeft,
                                        //color: Colors.grey,
                                        child: Text(
                                          snapshot.data![index]['ngaynk'],
                                          style: const TextStyle(fontSize: 20),
                                          //softWrap: true,
                                        )),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      alignment: Alignment.topLeft,
                                      child: SelectableText(
                                        snapshot.data![index]['noidungcv1'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ))),
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
