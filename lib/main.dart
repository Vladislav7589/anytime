import 'dart:ui';


import 'package:any_time/screens/address.dart';
import 'package:any_time/screens/coffee.dart';
import 'package:any_time/screens/feedback.dart';
import 'package:any_time/screens/franchise.dart';
import 'package:any_time/screens/loginPage.dart';
import 'package:any_time/screens/menu.dart';
import 'package:any_time/screens/our_product.dart';
import 'package:any_time/screens/profile.dart';
import 'package:any_time/screens/school.dart';
import 'package:any_time/screens/shopping_cart.dart';
import 'package:any_time/screens/team.dart';
import 'package:any_time/models/shopping_cart.dart';
import 'package:any_time/screens/vacancy.dart';
import 'package:any_time/styles/buttons.dart';
import 'package:any_time/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'globals.dart';
import 'models/menu_items.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
          })),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('ru')],
      locale: const Locale('ru'),
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<Main> with SingleTickerProviderStateMixin {
  GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();

  MenuService menuService = MenuService();
  late AnimationController animationController;
  late Animation<double> animation;


  @override
  void initState() {
    super.initState();
    menuService.currentPage = Item.menu;
  }
  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
      switch(selectedIndex){
        case 0:
          if (menuService.currentPage != Item.menu) {
            menuService.currentPage = Item.menu;
            _globalKey.currentState!.pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => MenuPage()),
                    (route) => false);
          }
          break;
        case 1:
          if (menuService.currentPage != Item.address) {
            menuService.currentPage = Item.address;
            _globalKey.currentState!
                .push(MaterialPageRoute(builder: (context) => AddressPage()));
          }
          break;
        case 2:
          if (menuService.currentPage != Item.shoppingCart) {
            menuService.currentPage = Item.shoppingCart;
            _globalKey.currentState!.push(MaterialPageRoute(builder: (context) => ShoppingCartPage()));
          }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // меняем body на нужный

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white,),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              child: IconButton(
                splashRadius: 1,
                icon: Icon( Icons.account_circle_rounded,size: 35,color: Colors.white, ),
                onPressed: () {
                  print( isLogin);
                  if (menuService.currentPage != Item.profile && isLogin) {
                    menuService.currentPage = Item.profile;
                    _globalKey.currentState!.push(MaterialPageRoute(builder: (context) => ProfilePage()));
                  }
                  if (menuService.currentPage != Item.login && !isLogin) {
                    menuService.currentPage = Item.login;
                    _globalKey.currentState!.push(MaterialPageRoute(builder: (context) =>  LoginPage()));
                  }
              },),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xDF290505),
        toolbarHeight: 55,
        title: SizedBox(
          child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              onPressed: () { },
              child: Image.asset(
                "assets/logo_any.png",
                fit: BoxFit.contain,
                height: 50,
              )),
        ),
        centerTitle: true,
      ),
      body: Container(
        child:  WillPopScope(
              onWillPop: () async {
                if (_globalKey.currentState!.canPop()) {
                  _globalKey.currentState!.pop();
                  return false;
                }

                return true;
              },
              child: Navigator(
                key: _globalKey,
                onGenerateRoute: (RouteSettings settings) =>
                    MaterialPageRoute(builder: (context) {
                      return MenuPage();
                    }),
              ),
            ),

      ),
      drawer:  Drawer(
        backgroundColor: Color(0xDF290505),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Image.asset("assets/logo_any.png",
                  height: 100,),
              ),
              drawMenu(),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xDF290505),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: selectedIndex,
        onTap: onItemTap,
        selectedFontSize: 15.0,
        unselectedFontSize: 13.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.coffee_cup),
            title: Text("Меню"),

          ),
           const BottomNavigationBarItem(
            icon: Icon(CustomIcons.map_marker),
            title: Text("Адреса"),
          ),
          BottomNavigationBarItem(
            icon:  Container(
              width: 90,
              child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    Icon(Icons.shopping_cart),
                    Positioned(
                      left: 45,
                      top: 1,
                      child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red,),

                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 1.5, 4, 1.5),
                              child: Text("$total р",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
                            )),
                    )

                  ]
              ),
            ),
            title: Text("Корзина"),
          ),
        ],
      ),

    );
  }

  Widget drawMenu() {
    // элементы меню
    return Container(
      child: Column(
        children: [
          drawMenuItem(1, "Меню", "assets/icons/menu.png",),
          drawMenuItem(3, "Наша команда", "assets/icons/team.png"),
          drawMenuItem(2, "Адреса кофеен", "assets/icons/marker.png"),
          drawMenuItem(4, "Наше зерно", "assets/icons/coffee.png"),
          drawMenuItem(5, "Школа бариста", "assets/icons/school.png"),
          drawMenuItem(6, "Вакансии", "assets/icons/vacancy.png"),
          drawMenuItem(7, "Отзыв", "assets/icons/feedback.png"),
          drawMenuItem(8, "Франшиза", "assets/icons/franchise.png"),
          drawMenuItem(9, "Наши товары", "assets/icons/products.png"),

        ],
      ),
    );
  }

  Widget drawMenuItem(int id, String title, String icon) {
    // отрисовка меню
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          switch (id) {
            case 1:
              if (menuService.currentPage != Item.menu) {
                menuService.currentPage = Item.menu;
                _globalKey.currentState!.pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => MenuPage()),
                        (route) => false);
              }
              break;
            case 2:
              if (menuService.currentPage != Item.address) {
                menuService.currentPage = Item.address;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => AddressPage()));
              }
              break;
            case 3:
              if (menuService.currentPage != Item.team) {
                menuService.currentPage = Item.team;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => TeamPage()));
              }break;
            case 4:
              if (menuService.currentPage != Item.coffee) {
                menuService.currentPage = Item.coffee;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => CoffeePage()));
              }break;
            case 5:
              if (menuService.currentPage != Item.school) {
                menuService.currentPage = Item.school;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => SchoolPage()));
              }break;
            case 6:
              if (menuService.currentPage != Item.vacancy) {
                menuService.currentPage = Item.vacancy;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => VacancyPage()));
              }break;
            case 7:
              if (menuService.currentPage != Item.feedback) {
                menuService.currentPage = Item.feedback;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => FeedbackPage()));
              }break;
            case 8:
              if (menuService.currentPage != Item.franchise) {
                menuService.currentPage = Item.franchise;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => FranchisePage()));
              }break;
            case 9:
              if (menuService.currentPage != Item.ourProduct) {
                menuService.currentPage = Item.ourProduct;
                _globalKey.currentState!
                    .push(MaterialPageRoute(builder: (context) => OurProductPage()));
              }break;

            default:
              break;
          }
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Row(

            children: [
              Image.asset(

                icon,
                height: 27,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
