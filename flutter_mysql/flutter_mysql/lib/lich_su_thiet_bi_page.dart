import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_path.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';

class LichSuThietBi extends StatefulWidget {
  const LichSuThietBi({Key? key, required this.thiet_bi_id}) : super(key: key);
  final int thiet_bi_id;

  @override
  State<LichSuThietBi> createState() => _LichSuThietBiState();
}

class _LichSuThietBiState extends State<LichSuThietBi> {
  late int id;
  Future<List> getLichSuThietBi() async {
    var uri = Uri.parse(AppPath.getLichSuThietBiPath);
    var response = await http.post(uri, body: {"thiet_bi_id": id.toString()});
    return json.decode(response.body);
  }

  @override
  void initState() {
    id = widget.thiet_bi_id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lịch sử thiết bị")),
      body: FutureBuilder<List>(
          future: getLichSuThietBi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return
                  //Text(snapshot.data);
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var temp = snapshot.data![index]['honghoc'];
                        return ListTile(
                          title: Card(
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.green, width: 3),
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
                                                  topRight:
                                                      Radius.circular(12))),
                                          alignment: Alignment.topLeft,
                                          //color: Colors.grey,
                                          child: Text(
                                            snapshot.data![index]['ngayth'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                            //softWrap: true,
                                          )),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          alignment: Alignment.topLeft,
                                          child: Html(data: temp, style: {
                                            "p": Style(
                                                fontSize: const FontSize(20))
                                          })),
                                    ],
                                  ))),
                        );
                      });
            } else {
              return Container();
            }
          }),
    );
  }
}
