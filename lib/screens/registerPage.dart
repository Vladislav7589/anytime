import 'package:any_time/models/menu_items.dart';
import 'package:any_time/screens/profile.dart';
import 'package:any_time/styles/buttons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../globals.dart';
import 'menu.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  MenuService menuService = MenuService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    menuService.currentPage = Item.registr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Регистрация',
                        style: TextStyle(
                            color: Color(0xDF290505),
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const  Text(
                    '  Чтобы совершать заказ через приложение необходимо зарегистрироваться! Введите свои данные в форме ниже.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Center(child: Icon(Icons.account_circle,size: MediaQuery.of(context).size.width * 0.55,color: Colors.black26,)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xDF290505),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Имя',labelStyle: TextStyle(color: Colors.black),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xDF290505),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'E-mail',labelStyle: TextStyle(color: Colors.black),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xDF290505),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Номер телефона',labelStyle: TextStyle(color: Colors.black),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xDF290505),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Пароль',labelStyle: TextStyle(color: Colors.black),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    controller: secondPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xDF290505),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Повторите пароль',labelStyle: TextStyle(color: Colors.black),),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && usernameController.text.isNotEmpty) {
                      Uri url = Uri.parse("http://192.168.0.105:1337/auth/local/register");

                      var response = await http.post(url, body: {
                        "username": usernameController.text,
                        "email": emailController.text.trim(),
                        "password": passwordController.text,
                        "number": numberController.text
                      });

                      if (response.statusCode == 200) {
                        var body = jsonDecode(response.body);

                        name = body["user"]["username"].toString();
                        email = body["user"]["email"].toString();
                        number = body["user"]["number"].toString();
                        jwt = body["jwt"].toString();
                        Fluttertoast.showToast(msg: 'Вы зарегистрированы!', timeInSecForIosWeb: 4);
                        isLogin = true;
                        print(isLogin);
                        menuService.currentPage = Item.profile;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                      } else {
                        if (response.body.toString().contains('ValidationError')) {
                          Fluttertoast.showToast(
                              msg: 'Неверный формат электронной почты!',
                              timeInSecForIosWeb: 2);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Неверный логин или пароль!',
                              timeInSecForIosWeb: 2);
                        }
                      }
                    } else if(passwordController.text != secondPasswordController.text){

                      secondPasswordController.text='';
                      passwordController.text='';
                      Fluttertoast.showToast(
                          msg: 'Пароли не совпадают!', timeInSecForIosWeb: 2);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Заполните все поля!', timeInSecForIosWeb: 2);
                    }
                  },
                  style: raisedButtonStyle.copyWith(

                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 15, vertical: 2))),
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        'Зарегистрироваться',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      String hitName, TextEditingController textEditingControl, int maxLine) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 8),
      child: Container(
          child: TextField(
        maxLines: maxLine,
        controller: textEditingControl,
        decoration: InputDecoration(
          hoverColor: Colors.black,
          focusColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: hitName,
          labelStyle: TextStyle(color: Colors.black),
        ),
      )),
    );
  }
}
