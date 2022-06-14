import 'dart:ffi';

import 'models/shopping_cart.dart';

List<Basket> korzina = [];
int total = 0;
String address =  "";
String jwt=  "", name=  "", email=  "" ,number =  "";

int selectedIndex = 0;
bool isLogin = false;
KorzinaPrica(){
  total = 0;
  for(int i=0;i!=korzina.length;i++){
    total = total + korzina[i].count * korzina[i].price;
  }
}