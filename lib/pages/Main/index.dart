import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabIcons = [
    {
      'icon': 'lib/assets/ic_public_home_normal.png',
      'selectedIcon': 'lib/assets/ic_public_home_active.png',
      'label': '首页',
    },
    {
      'icon': 'lib/assets/ic_public_pro_normal.png',
      'selectedIcon': 'lib/assets/ic_public_pro_active.png',
      'label': '分类',
    },
    {
      'icon': 'lib/assets/ic_public_cart_normal.png',
      'selectedIcon': 'lib/assets/ic_public_cart_active.png',
      'label': '购物车',
    },
    {
      'icon': 'lib/assets/ic_public_my_normal.png',
      'selectedIcon': 'lib/assets/ic_public_my_active.png',
      'label': '我的',
    },
  ];

  int _currentIndex = 0;

  List<BottomNavigationBarItem> _getTabItems() {
    return _tabIcons.map((tab) {
      return BottomNavigationBarItem(
        icon: Image.asset(tab['icon']!, width: 30, height: 30),
        activeIcon: Image.asset(tab['selectedIcon']!, width: 30, height: 30),
        label: tab['label']!,
      );
    }).toList();
  }

  List<Widget> _getTabPages() {
    return [HomePage(), CategoryPage(), CartPage(), MinePage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getTabPages()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: _getTabItems(),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
