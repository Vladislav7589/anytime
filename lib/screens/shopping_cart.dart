import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../globals.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {

  MenuService menuService = MenuService();
  bool isSwitched = false;

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
  @override
  void initState() {
    menuService.currentPage = Item.shoppingCart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  Text('Корзина',
                      style: TextStyle(
                          color: Color(0xDF290505),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment : MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    //color: Colors.white,
                    onPressed: () {
                      print("до ${ korzina.length}");
                      setState(() {
                        korzina.clear();
                        KorzinaPrica();
                      });
                      print("после ${ korzina.length}");
                    },
                    child:  Text("Очистить",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
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
                  return Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: korzina.length,
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
                                                          "http://192.168.0.105:1337${snapshot.data["type2"][korzina[index].typeId]["product"][korzina[index].productId]["image"]["url"]}")),

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
                                                                Text("${snapshot.data["type2"][korzina[index].typeId]["product"][korzina[index].productId]["name"]}",
                                                                        textAlign: TextAlign.start,
                                                                        style: const TextStyle(

                                                                            color: Color(0xDF290505),
                                                                            fontSize: 15.0)),
                                                                Text("${snapshot.data["type2"][korzina[index].typeId]["product"][korzina[index].productId]["grams"]}",
                                                                    textAlign: TextAlign.start,
                                                                    style: const TextStyle(

                                                                        color: Color(0xFF575E67),
                                                                        fontSize: 12.0)),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex:2,
                                                            child: Text("${korzina[index].count * 69} р.",textAlign: TextAlign.center,
                                                                style: const TextStyle(
                                                                    color: Color(0xDF290505),
                                                                    fontWeight:  FontWeight.bold,
                                                                    fontSize: 14.0)),
                                                          ),
                                                          Expanded(
                                                            flex:4,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 25,
                                                                  width: 30,
                                                                  child: FlatButton(onPressed: (){
                                                                    setState(() {
                                                                      if(korzina[index].count>1)korzina[index].count--;
                                                                      else korzina.removeAt(index);
                                                                      KorzinaPrica();
                                                                    });
                                                                  }, child: new Text(
                                                                    "-",
                                                                    style: new TextStyle(
                                                                      fontSize: 18.0,
                                                                    ),

                                                                  ),
                                                                    splashColor: Colors.red,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 10,left: 10),
                                                                  child: Text("${korzina[index].count}",
                                                                      style: const TextStyle(
                                                                          color: Color(0xDF290505),
                                                                          fontWeight:  FontWeight.bold,
                                                                          fontSize: 14.0)),
                                                                ),
                                                                Container(
                                                                  height: 25,
                                                                  width: 30,
                                                                  child: FlatButton(onPressed: (){
                                                                    setState(() {
                                                                      if(korzina[index].count<15)korzina[index].count++;
                                                                      KorzinaPrica();
                                                                    });
                                                                  }, child: new Text(
                                                                    "+",
                                                                    style: new TextStyle(
                                                                      fontSize: 18.0,
                                                                    ),

                                                                  ),
                                                                    splashColor: Colors.green,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
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
                      )


                  ;

                }
              },
            ),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Итого:",style: TextStyle(fontSize: 20),),
                  Text("$total р",style: TextStyle(fontSize: 20),),
                ],
              ),
            SizedBox(height: 10,),
            Text('Ресторан:',
                  style: TextStyle(
                      color: Color(0xDF290505),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
            Text('Красный путь 11/1',
                style: TextStyle(
                  color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    SizedBox(width: 20,),
                    Text("Заказ на вынос",style: TextStyle(fontSize: 20),),
                  ],
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value){
                    setState(() {
                      isSwitched=value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.brown,
                  activeColor: Color(0xDF290505),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20),
              child: RaisedButton(
                color: Color(0xB0290505),
                onPressed: () {

                },
                child:  Text("Оформить заказ на $total р",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

