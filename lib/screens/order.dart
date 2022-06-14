import 'dart:convert';

import 'package:any_time/globals.dart';
import 'package:any_time/models/menu_items.dart';
import 'package:any_time/models/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'item_detail.dart';

class OrderPage extends StatefulWidget {
  final int id;
  OrderPage({
    required this.id,
  });

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  MenuService menuService = MenuService();
  int ind = 0;
  late String status;
  late String order;

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/orders?id=${widget.id}");
    var response = await http.get(url);
    var body = json.decode(response.body);
    print(body);
    return body;
  }

  @override
  void initState() {
    menuService.currentPage = Item.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text('Заказ № ${widget.id}',
                    style: TextStyle(
                        color: Color(0xDF290505),
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          FutureBuilder(
            future: fetchData(),
            builder: (context, AsyncSnapshot snapshot) {
              status ="";
              print(snapshot.data[0]["order"].length);
              switch(snapshot.data[0]["status"]){
                case "prepared": status ="Готовится"; break;
                case "ready": status ="Готов"; break;
                case "issued": status ="Готов к выдаче"; break;
                default:break;
              }

              if (snapshot.data == null) {
                return Container(
                    child: Center(
                      child: CircularProgressIndicator(color: Color(0xDF290505),),
                    ));
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(crossAxisAlignment : CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment : MainAxisAlignment.spaceBetween,
                              children: [
                                Text("№ ${snapshot.data[0]["id"]} ",
                                    style: TextStyle(
                                        color: Color(0xDF290505),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0) //                 <--- border radius here
                                    ),
                                  ),
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(status,style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold
                                    )),
                                  )

                                  ,)
                              ],
                            ),
                            SizedBox(height: 8,),
                            Text(" ${DateFormat("yyyy-MM-dd HH:mm","ru").format(DateTime.parse(snapshot.data[0]["created_at"]))} ",
                                style: TextStyle(
                                    color: Color(0xDF290505),
                                    fontSize: 18
                                )),
                            SizedBox(height: 8,),
                            Text('Кофейня: ${snapshot.data[0]["place"]}',
                                style: TextStyle(
                                    color: Color(0xDF290505),
                                    fontSize: 18
                                )),
                            SizedBox(height: 8,),
                            Text(snapshot.data[0]["takeout"]? "Навынос":"В кофейне",
                                style: TextStyle(
                                    color: Color(0xDF290505),
                                    fontSize: 18
                                )),
                          ]),
                    ),


                  ],
                );

              }
            },
          ),

        ]),
      ),
    );
  }
}
