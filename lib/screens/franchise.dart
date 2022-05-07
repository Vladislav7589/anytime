import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class FranchisePage extends StatelessWidget {
  MenuService menuService = MenuService();


  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/franchise");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
  @override
  void initState() {
    menuService.currentPage = Item.franchise;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [

              ],
            ),
            Container(
              height: 150,
              child: Image.asset("assets/franchise.jpg",
                fit: BoxFit.fitHeight,

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
                  return  Column(children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(snapshot.data["description"],
                        style: TextStyle(
                            color: Color(0xDF290505),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify)
                    ),
                    InkWell(
                        child: new Text(
                          'Скачать анкету',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => launch('https://www.coffee-anytime.ru/downloads/files/profile-coffee-anytime.pdf')
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Благодарим за внимание к нашей будущей франшизе!",
                            style: TextStyle(
                                color: Color(0xDF290505),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold))
                    ),
                  ],) ;

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
