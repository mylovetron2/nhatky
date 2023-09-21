import 'package:flutter/material.dart';
import 'package:flutter_mysql/app_path.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditData extends StatefulWidget {
  const EditData({Key? key, required this.list, required this.index})
      : super(key: key);
  final List list;
  final int index;

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  //TextEditingController stt = TextEditingController();
  String stt = '';
  TextEditingController ngaynk = TextEditingController();
  TextEditingController noidungcv1 = TextEditingController();
  TextEditingController noidungcv2 = TextEditingController();

  void editData() {
    var url = Uri.parse(AppPath.editNhatKy);

    http.post(url, body: {
      "stt": stt,
      "noidungcv1": noidungcv1.text,
      "noidungcv2": noidungcv2.text,
    });
  }

  @override
  void initState() {
    stt = widget.list[widget.index]['stt'];
    noidungcv1 =
        TextEditingController(text: widget.list[widget.index]['noidungcv1']);
    noidungcv2 =
        TextEditingController(text: widget.list[widget.index]['noidungcv2']);
    ngaynk = TextEditingController(text: widget.list[widget.index]['ngaynk']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EDIT DATA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
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
                    // onTap: () async {
                    //   DateTime? pickedDate = await showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(2020),
                    //       lastDate: DateTime(2100));

                    //   if (pickedDate != null) {
                    //     String formattedDate =
                    //         DateFormat('dd-MM-yyyy').format(pickedDate);
                    //     print(formattedDate);
                    //     setState(() {
                    //       ngaynk.text =
                    //           formattedDate; //set output date to TextField value.
                    //     });
                    //   } else {
                    //     print("Date is not selected");
                    //   }
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    style: const TextStyle(fontSize: 20),
                    maxLines: 10,
                    controller: noidungcv1,
                    decoration: const InputDecoration(
                      labelText: "Chiều",
                      hoverColor: Colors.blue,
                      //enabledBorder: OutlineInputBorder(borderSide(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ),
                Container(
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
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton(
                      onPressed: () {
                        editData();
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                      child: const Text(
                        "Edit Data",
                        style: TextStyle(fontSize: 20),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
