import 'package:flutter/material.dart';
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
  final List<BannerList> bannerList = [
    BannerList(id: '1', url: 'https://picsum.photos/200/300?random=1'),
    BannerList(id: '2', url: 'https://picsum.photos/200/300?random=2'),
    BannerList(id: '3', url: 'https://picsum.photos/200/300?random=3'),
  ];

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
