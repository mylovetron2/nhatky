//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mysql/lich_su_thiet_bi_page.dart';
import 'package:http/http.dart' as http;
import 'app_path.dart';
import 'mainmenu.dart';

class ThietBi extends StatefulWidget {
  const ThietBi({Key? key}) : super(key: key);

  @override
  State<ThietBi> createState() => _ThietBiState();
}

class _ThietBiState extends State<ThietBi> {
  String searchString = "";

  Future<List> getListThietBi() async {
    var uri = Uri.parse(AppPath.getListThietBiPath);
    var response = await http.get(uri);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Thiết bị"),
          actions: const [
            MainMenu(),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 0,
            ),
            Expanded(
              child: FutureBuilder<List>(
                future: getListThietBi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return

                        //Text(snapshot.data);
                        ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data![index]["tenthietbi"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchString) ||
                                  snapshot.data![index]["tenthietbi"]
                                      .toString()
                                      .toUpperCase()
                                      .contains(searchString)) {
                                return ListTile(
                                  title: Card(
                                      shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.green, width: 3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      shadowColor: Colors.blueGrey,
                                      elevation: 5,
                                      child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  alignment: Alignment.topLeft,
                                                  //color: Colors.grey,
                                                  child: Text(
                                                    snapshot.data![index]
                                                        ['tenthietbi'],
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  )),
                                            ],
                                          ))),
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LichSuThietBi(
                                                  thiet_bi_id: int.parse(
                                                      snapshot.data![index]
                                                          ['thiet_bi_id']))))
                                      .then((value) {
                                    getListThietBi();
                                    setState(() {
                                      getListThietBi();
                                    });
                                  }),
                                );
                              } else
                                return Container();
                            });
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ));
  }
}
