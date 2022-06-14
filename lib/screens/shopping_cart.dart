import 'dart:convert';

import 'package:any_time/screens/menu.dart';
import 'package:any_time/utils.dart';
import 'package:any_time/widgets/dialog_addeses.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../globals.dart';
import 'loginPage.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  MenuService menuService = MenuService();
  bool isSwitched = false;
  late Enum ready;
  late String value;
  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu-2-s");
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

    if(!korzina.isEmpty) {
      return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  ListView(
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
                                                          "http://192.168.0.105:1337${snapshot.data[korzina[index].typeId]["item"][korzina[index].productId]["image"]["url"]}")),

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
                                                                Text("${snapshot.data[korzina[index].typeId]["item"][korzina[index].productId]["name"]}",
                                                                        textAlign: TextAlign.start,
                                                                        style: const TextStyle(

                                                                            color: Color(0xDF290505),
                                                                            fontSize: 15.0)),
                                                                Text("${korzina[index].grams}",
                                                                    textAlign: TextAlign.start,
                                                                    style: const TextStyle(

                                                                        color: Color(0xFF575E67),
                                                                        fontSize: 12.0)),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex:2,
                                                            child: Text("${korzina[index].count * korzina[index].price} р.",textAlign: TextAlign.center,
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
                      );

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
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        contentPadding : EdgeInsets.all(8),
                      title: Text('Выберите кофейню:'),
                      content: SetupAlertDialoadt(context),
                    );
                  }).then((_)=>setState((){}));

            }, child: address != ""? Text(address,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)): Text("Выбрать", style: TextStyle(
                color: Colors.red,
                fontSize: 20.0,
                fontWeight: FontWeight.bold))),
              
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
                onPressed: () async {
                  String infoJson = jsonEncode(korzina);
                  print(infoJson);
                  if(isLogin){
                    http.Response response = await newOrders(address, infoJson,  email, "prepared", isSwitched);
                    if (response.statusCode == 200) {
                      print("Good");
                      korzina.clear();
                      setState(() {

                      });
                      Fluttertoast.showToast(msg: 'Заказ сформирован! \n Посмотреть его статус можно в профиле.', timeInSecForIosWeb: 6,fontSize:18);

                    } else {
                      print("Not Good ${ response.statusCode}");
                    }
                  } else{
                    Fluttertoast.showToast(msg: 'Вы должны быть авторизованы!', timeInSecForIosWeb: 4);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
                child:  Text("Оформить заказ на $total р",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
    } else {
      return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  ListView(
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
            Column(children: [
              Icon(Icons.shopping_cart,size: MediaQuery.of(context).size.width * 0.75,color: Colors.black26,),
              Text("Корзина пуста",style: TextStyle(fontSize: 35),),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: RaisedButton(
                    color: Color(0xB0290505),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MenuPage()));
                      setState(() {
                        menuService.currentPage = Item.menu;
                      });
                    },
                    child:  Text("Перейти в меню",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
              ),
            ],)
          ],
        ),
      ),
    );
    }
  }
}