import 'dart:convert';
import 'package:any_time/styles/buttons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class RegistrationWidget extends StatelessWidget {
  final maxLines = 5;
  const RegistrationWidget({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.numberController,
    required this.messageController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController numberController;
  final TextEditingController messageController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const  Text(
            '  Чтобы совершать заказ через приложение необходимо зарегистрироваться! Введите свои данные в форме ниже.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.justify,
          ),
        ),
        Center(child: Icon(Icons.account_circle,size: MediaQuery.of(context).size.width * 0.55,color: Colors.black26,)),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xDF290505),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Имя'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xDF290505),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'E-mail'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xDF290505),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Номер телефона'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(8.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xDF290505),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Пароль'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && numberController.text.isNotEmpty && messageController.text.isNotEmpty){

                    http.Response response = await subscribeToPromotions(nameController.text, emailController.text, numberController.text,messageController.text);
                    if (response.statusCode == 200) {
                      Fluttertoast.showToast(msg: 'Благодарим за отзыв, мы с вами свяжемся!',timeInSecForIosWeb: 2);
                      nameController.text = '';
                      emailController.text = '';
                      numberController.text = '';
                      messageController.text = '';
                    } else {
                      if(response.body.toString().contains('ValidationError')){
                        Fluttertoast.showToast(msg: 'Неверный формат электронной почты!',timeInSecForIosWeb: 2);
                      }else{
                        Fluttertoast.showToast(msg: 'Произошла ошибка!',timeInSecForIosWeb: 2);
                      }
                    }

                  }else{
                    Fluttertoast.showToast(msg: 'Заполните все поля!',timeInSecForIosWeb: 2);
                  }

                },
                child: Container(
                  child: FittedBox(
                    child: Text(
                      'Зарегистрироваться',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                style: raisedButtonStyle.copyWith(

                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 2))),
              ),
            ),

          ],
        )
      ],
    );
  }
}
