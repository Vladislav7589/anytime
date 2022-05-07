import 'models/shopping_cart.dart';

List<Basket> korzina = [];
int total = 0;
int selectedIndex = 0;
KorzinaPrica(){
  total = 0;
  for(int i=0;i!=korzina.length;i++){
    total = total + korzina[i].count * 69;
  }
}