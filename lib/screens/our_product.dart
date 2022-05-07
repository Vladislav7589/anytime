import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class OurProductPage extends StatelessWidget {
  MenuService menuService = MenuService();


  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/our-products");
    var response = await http.get(url);
    var body = json.decode(response.body);
    return body;
  }
  @override
  void initState() {
    menuService.currentPage = Item.ourProduct;
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
                Text('Наши товары',
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
                return  ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data["Type3"].length,
                   itemBuilder: (BuildContext context, int ind) {
                     return Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('${snapshot.data["Type3"][ind]["title"]}',
                               style: TextStyle(
                                   color: Color(0xDF290505),
                                   fontSize: 25.0,
                                   fontWeight: FontWeight.bold)),
                         ),
                         Container(
                         child: GridView.builder(
                           shrinkWrap: true,
                           itemCount: snapshot.data["Type3"][ind]["product2"].length,
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
                                     child:  Column(children: [
                                       Expanded(
                                           flex: 9,
                                           child: ClipRRect(
                                               borderRadius: BorderRadius.circular(15.0),
                                               child: Image.network("http://192.168.0.105:1337${snapshot.data["Type3"][ind]["product2"][index]["image"]["url"]}"))


                                       ),
                                       const SizedBox(
                                         height: 7,
                                       ),
                                       Expanded(
                                         flex: 1,
                                         child: Text("${snapshot.data["Type3"][ind]["product2"][index]["name"]}",
                                             textAlign: TextAlign.center,
                                             style: const TextStyle(

                                                 color: Color(0xFF575E67),
                                                 fontSize: 15.0)),
                                       ),
                                       Expanded(
                                         flex: 1,
                                         child: Text("${snapshot.data["Type3"][ind]["product2"][index]["info"]}",
                                             style: const TextStyle(
                                                 color: Color(0xDF290505),
                                                 fontWeight:  FontWeight.bold,
                                                 fontSize: 14.0)),
                                       ),
                                       Expanded(
                                         flex: 1,
                                         child: Text("${snapshot.data["Type3"][ind]["product2"][index]["price"]}",
                                             style: const TextStyle(
                                                 color: Color(0xDF290505),
                                                 fontWeight:  FontWeight.bold,
                                                 fontSize: 14.0)),
                                       ),
                                     ]),
                                   ),

                                 )

                             );  },

                         ),
                   ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: snapshot.data["Type3"][ind]["description"] != null? Text('${snapshot.data["Type3"][ind]["description"]}',
                               style: TextStyle(
                                   color: Color(0xDF290505),
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.bold)):SizedBox()
                         ),
                       ],
                     );
                     },
                )
;

              }
            },
          ),
        ]),)
      );

  }
}
