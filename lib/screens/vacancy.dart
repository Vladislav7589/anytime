import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:any_time/models/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class VacancyPage extends StatelessWidget {
  MenuService menuService = MenuService();


  Future fetchData() async {
    Uri url = Uri.parse("http://192.168.0.105:1337/menu");
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          Text('Вакансии',
              style: TextStyle(
                  color: Color(0xDF290505),
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
