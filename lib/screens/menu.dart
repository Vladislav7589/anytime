import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:any_time/models/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'item_detail.dart';

class MenuPage extends StatefulWidget {
  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  MenuService menuService = MenuService();
  int ind = 0;

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu-2-s");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }

  @override
  void initState() {
    menuService.currentPage = Item.menu;
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
                Text('Меню',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return    Padding(
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    ind = index;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(borderRadius:     BorderRadius.circular(
                                      10),),
                                  child: Text("${snapshot.data[index]["title"]}",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: ind == index? Color(0xDF290505): Color(0x50290505),
                                          fontWeight:  FontWeight.bold
                                      )
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data[ind]["item"].length,
                        primary: false,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 3/5,
                          maxCrossAxisExtent: 300,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return  Padding(
                              padding: EdgeInsets.all(8),
                              child:  Center(
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
                                    child: InkWell(
                                      onTap: (){

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemDetail(
                                          name: snapshot.data[ind]["item"][index]["name"],
                                          typeId: ind,
                                          productId: index,
                                          image: snapshot.data[ind]["item"][index]["image"]["url"],
                                          description: snapshot.data[ind]["item"][index]["description"] != null? snapshot.data[ind]["item"][index]["description"]: "Описание отсутствует",
                                        )));

                                      },
                                      child: Column(children: [
                                         ClipRRect(
                                                borderRadius: BorderRadius.circular(15.0),
                                                child: Image.network("http://192.168.0.105:1337${snapshot.data[ind]["item"][index]["image"]["url"]}")),



                                        Expanded(
                                          flex: 2,
                                          child: Text("${snapshot.data[ind]["item"][index]["name"]}",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color: Color(0xFF575E67),
                                                  fontSize: 15.0)),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: ListView.separated(
                                                shrinkWrap : true,
                                                itemCount: snapshot.data[ind]["item"][index]["variant"].length,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context, int ind2) {
                                                  return Row(
                                                    children: [
                                                      Text("${snapshot.data[ind]["item"][index]["variant"][ind2]["grams"]}",
                                                          style: const TextStyle(
                                                              color: Color(0xDF290505),
                                                              fontWeight:  FontWeight.bold,
                                                              fontSize: 13.0)),
                                                    ],
                                                  );
                                                }, separatorBuilder: (BuildContext context, int index) {
                                                return Text("/",style: const TextStyle(
                                                    color: Color(0xDF290505),

                                                    fontSize: 18.0));
                                              },),
                                            )

                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: ListView.separated(
                                                shrinkWrap : true,
                                              itemCount: snapshot.data[ind]["item"][index]["variant"].length,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (BuildContext context, int ind2) {
                                              return Row(
                                                children: [
                                                  Text("${snapshot.data[ind]["item"][index]["variant"][ind2]["price"]}",
                                                      style: const TextStyle(
                                                          color: Color(0xDF290505),
                                                          fontWeight:  FontWeight.bold,
                                                          fontSize: 13.0)),
                                                  if(snapshot.data[ind]["item"][index]["variant"].length - 1 == ind2 ) Text(" р.",
                                                      style: const TextStyle(
                                                          color: Color(0xDF290505),
                                                          fontWeight:  FontWeight.bold,
                                                          fontSize: 13.0)),
                                                ],
                                              );
                                            }, separatorBuilder: (BuildContext context, int index) {
                                                  return Text("/",style: const TextStyle(
                                                      color: Color(0xDF290505),

                                                      fontSize: 18.0));
                                            },),
                                          )

                                        ),
                                      ]),
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
