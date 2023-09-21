import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mysql/app_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddData extends StatefulWidget {
  const AddData(
      {Key? key, required this.user, required this.cv1, required this.cv2})
      : super(key: key);
  final String user;
  final String cv1;
  final String cv2;

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController ngaynk = TextEditingController();
  TextEditingController noidungcv1 = TextEditingController();
  TextEditingController noidungcv2 = TextEditingController();

  Future<String> addData() async {
    var url = Uri.parse(AppPath.addNhatkyPath);
    var response = await http.post(url, body: {
      "ngaynk": ngaynk.text,
      "noidungcv1": noidungcv1.text,
      "noidungcv2": noidungcv2.text,
      "username": widget.user,
    });
    //if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data['message'];
    //}
    //return response.body;
  }

  @override
  void initState() {
    noidungcv1.text = widget.cv1;
    noidungcv2.text = widget.cv2;
    //ngaynk = TextEditingController(text: widget.list[widget.index]['ngaynk']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Data"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListView(
            children: <Widget>[
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    //margin: const EdgeInsets.all(12),

                    padding: const EdgeInsets.all(12),
                    child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Ngày",
                          labelText: "Ngày",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius:
                                  (BorderRadius.all(Radius.circular(10)))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  (BorderRadius.all(Radius.circular(10)))),
                        ),
                        style: const TextStyle(fontSize: 20),
                        controller: ngaynk,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            print(formattedDate);
                            setState(() {
                              ngaynk.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),

                  Container(
                    //margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      maxLines: 10,
                      controller: noidungcv1,
                      decoration: const InputDecoration(
                        labelText: "Sáng",
                        hoverColor: Colors.blue,
                        //enabledBorder: OutlineInputBorder(borderSide(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                  ),
                  Container(
                    //margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      maxLines: 10,
                      controller: noidungcv2,
                      decoration: const InputDecoration(
                        labelText: "Chiều",
                        hoverColor: Colors.blue,
                        //enabledBorder: OutlineInputBorder(borderSide(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                  ),

                  //const Padding(padding: EdgeInsets.all(10.0)),
                  // ignore: deprecated_member_use
                  Container(
                    child: RaisedButton(
                        onPressed: () async {
                          if (ngaynk.text == '') {
                            Fluttertoast.showToast(
                                msg: 'Ngày chưa được chọn',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            String r = await addData();
                            print(r);
                            if (r == 'success')
                              Navigator.pop(context);
                            else
                              Fluttertoast.showToast(
                                  msg: 'Ngày này đã được nhập',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                          }
                        },
                        color: Colors.blue,
                        child: const Text(
                          "Add Data",
                          style: TextStyle(fontSize: 20),
                        )),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
