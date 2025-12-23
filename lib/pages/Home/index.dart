import 'package:flutter/material.dart';
import 'package:hm_shop/apis/home.dart';
import 'package:hm_shop/components/Home/Category.dart';
import 'package:hm_shop/components/Home/HomeSlider.dart';
import 'package:hm_shop/components/Home/Hot.dart';
import 'package:hm_shop/components/Home/MoreList.dart';
import 'package:hm_shop/components/Home/Suggestion.dart';
import 'package:hm_shop/types/home.dart';
import 'package:hm_shop/utils/Toast.dart';

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

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  @override
  void initState() {
    super.initState();
    _initPage();
    Future.microtask(() {
      _key.currentState?.show();
    });
    _padding = 100;
    setState(() {});
  }

  // 监听滚动事件
  Future<void> _registerEvent() async {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        _getRecommendList();
      }
    });
  }

  // 调用 API 获取轮播图数据
  Future<void> _loadBannerData() async {
    bannerList = await HomeApi.getBannerList();
  }

  // 调用 API 获取分类数据
  Future<void> _loadCategoryData() async {
    categoryList = await HomeApi.getCategoryList();
  }

  // 特惠推荐
  Future<void> _loadHotRecommend() async {
    hotRecommendData = await HomeApi.getHotRecommend();
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await HomeApi.getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await HomeApi.getOneStopListAPI();
  }

  int _page = 1; // 当前页码
  int _limit = 10; // 每页数量
  bool _hasMore = true; // 是否有更多数据
  bool _isLoading = false; // 是否正在加载
  // 获取推荐列表
  Future<void> _getRecommendList() async {
    // 判断是否正在加载或没有更多数据
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    int requestLength = _limit * _page;
    _recommendList = await HomeApi.getRecommendListAPI({
      "limit": requestLength,
    });
    _isLoading = false;
    _hasMore = _recommendList.length >= requestLength;
    if (_recommendList.length < requestLength) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 初始化页面
  Future<void> _initPage() async {
    _page = 1;
    _hasMore = true;
    _isLoading = false;
    await _loadBannerData();
    await _loadCategoryData();
    await _loadHotRecommend();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    await _registerEvent();
    HMToast.show(context, "加载成功");
    _padding = 0;
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
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  final ScrollController _controller = ScrollController();
  double _padding = 0;
  // Vue 中的 ref 类似于 Flutter 中的 GlobalKey
  // 为什么一定要是RefreshIndicatorState类型? 因为RefreshIndicatorState是RefreshIndicator的State类，
  // 通过 GlobalKey<RefreshIndicatorState> _key = GlobalKey<RefreshIndicatorState>();
  // 获取RefreshIndicator的State类，然后调用其show()方法
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _padding),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScrollChildren(),
        ),
      ),
      onRefresh: () async {
        _initPage();
      },
    );
  }
}
