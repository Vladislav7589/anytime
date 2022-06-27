import 'dart:convert';

import 'package:any_time/globals.dart';
import 'package:any_time/models/menu_items.dart';
import 'package:any_time/models/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'item_detail.dart';
import 'order.dart';

class OrdersPage extends StatefulWidget {
  @override
  OrdersPageState createState() => OrdersPageState();
}

class OrdersPageState extends State<OrdersPage> {
  MenuService menuService = MenuService();
  int ind = 0;
  late String status;


  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/orders?email=$email");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }

  @override
  void initState() {
    menuService.currentPage = Item.orders;
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [

          Padding(
            padding: EdgeInsets.all(8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text('Заказы',
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
                return  Column(
                  children: [
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          status ="";
                          switch(snapshot.data[index]["status"]){
                            case "prepared": status ="Готовится"; break;
                            case "ready": status ="Готов"; break;
                            case "issued": status ="Готов к выдаче"; break;
                            default:break;
                          }

                          return  Padding(
                              padding: EdgeInsets.all(8),
                              child:  Center(
                                child:  Container(
                                  width: MediaQuery.of(context).size.width -16,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3.0,
                                              blurRadius: 5.0)
                                        ],
                                        color: Colors.white),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage(id: snapshot.data[index]["id"],)));

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Column(crossAxisAlignment : CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("№ ${snapshot.data[index]["id"]} ",
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
                                              Text(" ${DateFormat("yyyy-MM-dd HH:mm","ru").format(DateTime.parse(snapshot.data[index]["created_at"]))} ",
                                                  style: TextStyle(
                                                      color: Color(0xDF290505),
                                                      fontSize: 18
                                                  )),
                                              SizedBox(height: 8,),
                                              Text('Кофейня: ${snapshot.data[index]["place"]}',
                                                  style: TextStyle(
                                                      color: Color(0xDF290505),
                                                      fontSize: 18
                                                  )),
                                              SizedBox(height: 8,),
                                              Text(snapshot.data[index]["takeout"]? "Навынос":"В кофейне",
                                                  style: TextStyle(
                                                      color: Color(0xDF290505),
                                                      fontSize: 18
                                                  )),
                                              SizedBox(height: 8,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Итого:",style: TextStyle(fontSize: 20),),
                                                  Text("${snapshot.data[index]["total"]}  р",style: TextStyle(fontSize: 20),),
                                                ],
                                              ),

                                        ]),
                                      ),
                                    )),

                              )

                          );  },

                      ),
                    )

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
