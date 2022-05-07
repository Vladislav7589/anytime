import 'dart:convert';

import 'package:any_time/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:any_time/globals.dart';
import 'package:any_time/models/shopping_cart.dart';
class ItemDetail extends StatefulWidget {
  final String image, price, name,grams,description;
  final int typeId,productId;
  ItemDetail({
    required this.image,
    required this.typeId,
    required this.productId,
    required this.price,
    required this.name,
    required this.grams,
    required this.description
  });
  @override
  ItemDetailState createState() => ItemDetailState();
}

class ItemDetailState extends  State<ItemDetail> {


  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 15.0),
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
                return  Image.network("http://192.168.0.105:1337${widget.image}",
                    height: 250.0,
                    width: 100.0,
                    fit: BoxFit.contain
                );

              }
            },
          ),
            SizedBox(height: 10.0),
            Center(
              child: Text(widget.name,
                  style: const TextStyle(
                      color: Color(0xFF575E67),
                      fontSize: 24.0)),
            ),
          SizedBox(height: 10.0),
          Center(
            child: Text(widget.grams,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF17532))),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(widget.price,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF17532))),
          ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFB4B8B9))
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  var position = new Basket(typeId: widget.typeId, productId:widget.productId, count: 1, price: widget.price);
                  korzina.add(position);
                  setState(() {
                    KorzinaPrica();
                    selectedIndex = 0;
                  });
                  Navigator.of(context).pop(MenuPage());
                },
                child: Text("Добавить")
            )

        ]
      ),
    );
  }
}
