import 'dart:convert';

import 'package:any_time/widgets/subscribe_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class FeedbackPage extends StatelessWidget {
  MenuService menuService = MenuService();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    menuService.currentPage = Item.feedback;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Row(
                children: [
                  Text('Отзыв',
                      style: TextStyle(
                          color: Color(0xDF290505),
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SubscribeWidget(emailController: emailController, nameController: nameController, numberController: numberController, messageController: messageController,)
            ],
          ),
        ),
      ),
    );
  }
}


