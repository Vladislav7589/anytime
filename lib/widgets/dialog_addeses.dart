import 'dart:convert';
import 'package:any_time/globals.dart';
import 'package:any_time/styles/buttons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class SetupAlertDialoadt extends StatelessWidget {
  SetupAlertDialoadt(BuildContext context);


  Future fetchData2() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/addresses");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height-300, // Change as per your requirement
      width: MediaQuery.of(context).size.width-100,
      child: FutureBuilder(
          future: fetchData2(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    return  Column(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            color: Colors.red,
                            child:  Text("${snapshot.data[index]["region"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,

                                ))),

                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data[index]["address"].length,
                            itemBuilder: (context, int ind){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                child: TextButton(onPressed: (){
                                  address = "${snapshot.data[index]["address"][ind]["place"]} ${snapshot.data[index]["address"][ind]["address"]} ";
                                  Navigator.of(context).pop();
                                }, child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: '${snapshot.data[index]["address"][ind]["place"]} ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14,

                                          )),
                                      TextSpan(text: '${snapshot.data[index]["address"][ind]["address"]} ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,

                                          )),
                                    ],
                                  ),
                                )),
                              );
                            },),
                        ),
                      ],
                    );
                  },
                );            }
          }),
    );
  }
}