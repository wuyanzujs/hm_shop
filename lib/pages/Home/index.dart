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
  // 轮播图数据
  List<BannerItem> bannerList = [];
  // 分类数据
  List<CategoryHeadItem> categoryList = [];
  // 特惠推荐数据
  HotRecommendResult hotRecommendData = HotRecommendResult.fromJson({});
  // 热榜推荐
  HotRecommendResult _inVogueResult = HotRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  HotRecommendResult _oneStopResult = HotRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  @override
  void initState() {
    super.initState();
    _loadBannerData();
    _loadCategoryData();
    _loadHotRecommend();
    _getInVogueList();
    _getOneStopList();
  }

  // 调用 API 获取轮播图数据
  void _loadBannerData() async {
    bannerList = await HomeApi.getBannerList();
    setState(() {});
  }

  // 调用 API 获取分类数据
  void _loadCategoryData() async {
    categoryList = await HomeApi.getCategoryList();
    setState(() {});
  }

  // 特惠推荐
  void _loadHotRecommend() async {
    hotRecommendData = await HomeApi.getHotRecommend();
    setState(() {});
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await HomeApi.getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await HomeApi.getOneStopListAPI();
    setState(() {});
  }

  List<Widget> _getScrollChildren() {
    return <Widget>[
      SliverToBoxAdapter(child: HomeSlider(bannerList: bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      SliverToBoxAdapter(child: Category(categoryList: categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      SliverToBoxAdapter(child: Suggestion(hotRecommendData: hotRecommendData)),
      SliverToBoxAdapter(child: SizedBox(height: 20)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
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
