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
   int id;
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
  var order;

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/orders?id=${widget.id}");
    var response = await http.get(url);
    var body = json.decode(response.body);
    //order = json.decode(body["order"]);
    //print(order);
    return body;
  }
  Future fetchData2() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu-2-s");
    var response = await http.get(url);
    var body = json.decode(response.body);
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
              if (snapshot.data == null) {
                return Container(
                    child: Center(
                      child: CircularProgressIndicator(color: Color(0xDF290505),),
                    ));
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                order = json.decode(snapshot.data[0]["order"]);
                print(order);
                status ="";
                switch(snapshot.data[0]["status"]){
                  case "prepared": status ="Готовится"; break;
                  case "ready": status ="Готов"; break;
                  case "issued": status ="Готов к выдаче"; break;
                  default:break;
                }
                return  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Итого:",style: TextStyle(fontSize: 20),),
                                Text("${snapshot.data[0]["total"]}  р.",style: TextStyle(fontSize: 20),),
                              ],
                            ),
                          ]),
                    ),


                  ],
                );

              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: fetchData2(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                        child: CircularProgressIndicator(color: Color(0xDF290505),),
                      ));
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: order.length,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return  Padding(
                          padding: const EdgeInsets.only(bottom: 5,top: 5),
                          child: Center(
                            child:  Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3.0,
                                        blurRadius: 5.0)
                                  ],
                                  color: Colors.white),
                              child:  Container(
                                height: 80,
                                child: Row(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                          "http://192.168.0.105:1337${snapshot.data[order[index]["typeId"]]["item"][order[index]["productId"]]["image"]["url"]}")),

                                  Expanded(
                                    child:Padding(
                                      padding: const EdgeInsets.only(right: 8,left: 8),
                                      child: Row(
                                        mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex:5,
                                            child: Column(
                                              mainAxisAlignment : MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${snapshot.data[order[index]["typeId"]]["item"][order[index]["productId"]]["name"]}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(

                                                        color: Color(0xDF290505),
                                                        fontSize: 15.0)),
                                                Text("${order[index]["grams"]}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(

                                                        color: Color(0xFF575E67),
                                                        fontSize: 12.0)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex:2,
                                            child: Text("${order[index]["count"]} x ${order[index]["price"]} р.",textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Color(0xDF290505),
                                                    fontWeight:  FontWeight.bold,
                                                    fontSize: 14.0)),
                                          ),
                                          Expanded(
                                            flex:2,
                                            child: Text("${order[index]["count"]*order[index]["price"]}",textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Color(0xDF290505),
                                                    fontWeight:  FontWeight.bold,
                                                    fontSize: 14.0)),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ),
                                ]),
                              ),
                            ),

                          ),
                        );
                      },

                    ),
                  );

                }
              },
            ),
          ),

        ]),
      ),
    );
  }
}
