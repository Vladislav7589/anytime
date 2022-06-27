import 'package:any_time/globals.dart';
import 'package:any_time/models/menu_items.dart';
import 'package:any_time/screens/menu.dart';
import 'package:any_time/screens/profile.dart';
import 'package:any_time/screens/registerPage.dart';
import 'package:any_time/styles/buttons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  MenuService menuService = MenuService();
  @override
  void initState() {
    menuService.currentPage = Item.login;
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Авторизация',
                      style: TextStyle(
                          color: Color(0xDF290505),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Icon(Icons.account_circle,size: MediaQuery.of(context).size.width * 0.55,color: Colors.black26,)),
                  Column(
                    children: [
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
                        child: ElevatedButton(
                          onPressed: () async {
                            if( emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

                              Uri url = Uri.parse("http://192.168.0.105:1337/auth/local");

                              var response = await http.post(url, body: {"identifier" : emailController.text.trim(), "password": passwordController.text});

                              if (response.statusCode == 200) {
                                var body  = jsonDecode(response.body);

                                name = body["user"]["username"].toString();
                                email = body["user"]["email"].toString();
                                jwt = body["jwt"].toString();
                                Fluttertoast.showToast(msg: 'Здравствуйте',timeInSecForIosWeb: 4);
                                isLogin = true;
                                print( isLogin);
                                Navigator. pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));

                              } else {
                                if(response.body.toString().contains('ValidationError')){
                                  Fluttertoast.showToast(msg: 'Неверный формат электронной почты!',timeInSecForIosWeb: 2);
                                }else{
                                  Fluttertoast.showToast(msg: 'Неверный логин или пароль!',timeInSecForIosWeb: 2);
                                }
                              }

                            }else{
                              Fluttertoast.showToast(msg: 'Заполните все поля!',timeInSecForIosWeb: 2);
                            }

                          },
                          child: Container(
                            child: FittedBox(
                              child: Text(
                                'Войти',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          style: raisedButtonStyle.copyWith(

                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 2))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment : MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const  Text(
                              'Нет учетной записи?',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Text("|"),
                          TextButton(
                              onPressed:() {
                                menuService.currentPage = Item.registr;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
                          }, child: Text("Зарегистрироваться"))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),

        ),
      ),
    );

  }

}
