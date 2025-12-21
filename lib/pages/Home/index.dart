import 'package:flutter/material.dart';
import 'package:hm_shop/apis/home.dart';
import 'package:hm_shop/components/Home/Category.dart';
import 'package:hm_shop/components/Home/HomeSlider.dart';
import 'package:hm_shop/components/Home/Hot.dart';
import 'package:hm_shop/components/Home/MoreList.dart';
import 'package:hm_shop/components/Home/Suggestion.dart';
import 'package:hm_shop/types/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerItem> bannerList = [];

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  // 调用 API 获取轮播图数据
  Future<void> _loadBannerData() async {
    bannerList = await HomeApi.getBannerList();
    setState(() {});
  }

  List<Widget> _getScrollChildren() {
    return <Widget>[
      SliverToBoxAdapter(child: HomeSlider(bannerList: bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      SliverToBoxAdapter(child: Category()),
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      SliverToBoxAdapter(child: Suggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hot()),
              SizedBox(width: 10),
              Expanded(child: Hot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      MoreList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
