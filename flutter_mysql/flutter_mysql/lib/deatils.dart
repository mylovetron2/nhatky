import 'package:flutter/material.dart';
import 'package:ripozo/editdata.dart';
import 'package:http/http.dart' as http;
import 'package:ripozo/main.dart';

import 'editdata.dart';

class Details extends StatefulWidget {
  List list;
  int index;

  Details({this.list, this.index});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void deleteData() {
    var url = "http://<YOUR_IP>/dashboard/Ripozo/deletedata.php";

    http.post(url, body: {'name': "NAME"});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Are you sure you want to delete this record ${widget.list[widget.index]['name']}"),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "Ok Delete",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            deleteData();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Home(),
            ));
          },
          color: Colors.red,
        ),
        RaisedButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['name']}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                widget.list[widget.index]['name'],
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                widget.list[widget.index]['email'],
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                widget.list[widget.index]['mobile'],
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                widget.list[widget.index]['password'],
                style: TextStyle(fontSize: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: const Text("EDIT"),
                    color: Colors.green,
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditData(list: widget.list, index: widget.index),
                    )),
                  ),
                  RaisedButton(
                    child: Text("DELETE"),
                    color: Colors.red,
                    onPressed: () => confirm(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
