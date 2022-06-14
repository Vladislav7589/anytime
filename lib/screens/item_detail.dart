import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:any_time/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:any_time/globals.dart';
import 'package:any_time/models/shopping_cart.dart';

class ItemDetail extends StatefulWidget {
  final String image,description,name;
  final int typeId,productId;
  ItemDetail({
    required this.name,
    required this.image,
    required this.typeId,
    required this.productId,
    required this.description
  });
  @override
  ItemDetailState createState() => ItemDetailState();
}

class ItemDetailState extends  State<ItemDetail> {
  MenuService menuService = MenuService();
    late int price =0,count=1;
    int ind=0;
    late String grams;

  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu-2-s");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
    @override
    void initState() {
      menuService.currentPage = Item.itemDetail;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
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
            price = snapshot.data[widget.typeId]["item"][widget.productId]["variant"][ind]["price"];
            grams = snapshot.data[widget.typeId]["item"][widget.productId]["variant"][ind]["grams"];
            return
              SingleChildScrollView(
                child: Column(
                  children: [
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

                    Container(
                      height: 400,
                      child: Image.network("http://192.168.0.105:1337${widget.image}",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("${widget.name}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xDF290505),
                                fontSize: 24,

                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          child: Text(widget.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data[widget.typeId]["item"][widget.productId]["variant"].length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return   Padding(
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        ind = index;
                                        price = snapshot.data[widget.typeId]["item"][widget.productId]["variant"][ind]["price"];
                                        grams = snapshot.data[widget.typeId]["item"][widget.productId]["variant"][ind]["grams"];
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(borderRadius:     BorderRadius.circular(
                                          10),),
                                      child: Text("${snapshot.data[widget.typeId]["item"][widget.productId]["variant"][index]["grams"]}",
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
                    Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        Container(
                          child: IconButton(
                              splashRadius: 20,
                              onPressed: (){
                                setState(() {
                                  if(count>1) count--;

                                });
                              }, icon: Icon(Icons.remove)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,left: 10),
                          child: Text("$count",
                              style: const TextStyle(
                                  color: Color(0xDF290505),
                                  fontWeight:  FontWeight.bold,
                                  fontSize: 22.0)),
                        ),
                        IconButton(
                            splashRadius: 20,
                            onPressed: (){
                              setState(() {
                                if(count<15)count++;

                              });
                            }, icon: Icon(Icons.add)),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width-100,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Color(0xB0290505),
                          onPressed: () {
                            var position = new Basket(typeId: widget.typeId, productId:widget.productId, count: count, price: price,grams: grams);
                            korzina.add(position);
                            setState(() {
                              KorzinaPrica();
                              selectedIndex = 0;
                            });
                            Navigator.of(context).pop(MenuPage());
                          },
                          child: Text("В корзину ${ price*count} р.",style: TextStyle(color: Colors.white,fontSize: 20),)),
                    ),
                    SizedBox(height: 20.0),
                  ]
            ),
              );

          }
        },
      ),

    );
  }
}
