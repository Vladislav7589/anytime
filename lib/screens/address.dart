import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AddressPage extends StatefulWidget {
  @override
  AddressPageState createState() => AddressPageState();
}

class AddressPageState extends State<AddressPage> {
  MenuService menuService = MenuService();

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/addresses");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }

  @override
  void initState() {
    menuService.currentPage = Item.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Image.asset("assets/main.png",
          width: MediaQuery.of(context).size.width,
          ),
        Container(
          padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Color(0xDF290505),
            child: Column(children: [
              const Text("33 кофейни за 3 года!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 20,

                  )),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(text: 'Спасибо, что выбираете нас, уважаемые Омичи!',

                        style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,

                    )),
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(Icons.favorite,color: Colors.red,),
                      ),
                    ),
                  ],
                ),
              ),
            ],)
        ),
        FutureBuilder(
            future: fetchData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return  Column(
                          children: [
                            SizedBox(height: 5,),
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
                                  return RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child:  Icon(Icons.arrow_right,color: Colors.black,),
                                        ),
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
                                        TextSpan(text: '(${snapshot.data[index]["address"][ind]["hoursWorking"]})',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,

                                            )),

                                      ],
                                    ),
                                  );
                                  },),
                            ),
                          ],
                        );
                      },
                  ),
                );            }
            }),
      ]),
    );
  }
}
