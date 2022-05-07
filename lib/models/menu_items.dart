enum Item {
  menu,
  address,
  team,
  coffee,
  school,
  vacancy,
  feedback,
  franchise,
  ourProduct,
  shoppingCart
}

class MenuService {
  static final MenuService _instance = MenuService._internal();

  factory MenuService() => _instance;

  MenuService._internal() {
    _currentPage = Item.menu;
  }

  late Item _currentPage;

  Item get currentPage => _currentPage;

  set currentPage(Item item) => _currentPage = item;
}
