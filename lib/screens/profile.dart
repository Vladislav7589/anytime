import 'dart:convert';

import 'package:any_time/globals.dart';
import 'package:any_time/styles/buttons.dart';
import 'package:any_time/widgets/auth_widget.dart';
import 'package:any_time/widgets/registration_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'loginPage.dart';
import 'orders.dart';


class ProfilePage extends StatelessWidget {
  MenuService menuService = MenuService();

  @override
  void initState() {
    menuService.currentPage = Item.profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Row(
                  children: [
                    Text('Профиль',
                        style: TextStyle(
                            color: Color(0xDF290505),
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Center(child: Icon(Icons.account_circle,size: MediaQuery.of(context).size.width * 0.55,color: Colors.black26,)),
                Row(children: <Widget>[
                  _prefixIcon(Icons.account_box_rounded),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Имя пользователя:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                              color: Colors.black)),
                      SizedBox(height: 1),
                      Text(name,style: TextStyle(fontSize: 20,color: Colors.green))
                    ],
                  )
                ]),
                SizedBox(height: 20,),
                Row(children: <Widget>[
                  _prefixIcon(Icons.email),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Email:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                              color: Colors.black)),
                      SizedBox(height: 1),
                      Text(email,style: TextStyle(fontSize: 20,color: Colors.green))
                    ],
                  )
                ]),
                SizedBox(height: 20,),
                Row(children: <Widget>[
                  _prefixIcon(Icons.call),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Номер телефона:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                              color: Colors.black)),
                      SizedBox(height: 1),
                      Text(number==""? "Отсутствует": number,style: TextStyle(fontSize: 20,color: Colors.green))
                    ],
                  )
                ]),
                SizedBox(height: 20,),
                RaisedButton(
                    color: Color(0xB0290505),
                    onPressed: ()  {

                      Navigator. pushReplacement(context, MaterialPageRoute(builder: (context) => OrdersPage()));
                    },
                    child:  Container(width:MediaQuery.of(context).size.width -16 ,child: Text("Заказы",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: RaisedButton(
                    color: Color(0xB0290505),
                    onPressed: ()  {
                      name = "";
                      email = "";
                      jwt = "";
                      isLogin = false;
                      print( isLogin);
                      Navigator. pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child:  Text("Выйти",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
_prefixIcon(IconData iconData) {
  return ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
    child: Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(10.0))),
        child: Icon(
          iconData,
          size: 20,
          color: Colors.grey,
        )),
  );
}