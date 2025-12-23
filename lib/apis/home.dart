import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/types/home.dart';
import 'package:hm_shop/utils/Request.dart';

class HomeApi {
  static Future<List<BannerItem>> getBannerList() async {
    final data = await Request.get(HttpConstants.BANNER_PATH) as List;
    return data.map((item) => BannerItem.fromJson(item)).toList();
  }

  static Future<List<CategoryHeadItem>> getCategoryList() async {
    final data = await Request.get(HttpConstants.CATEGORY_HEAD_PATH) as List;
    return data.map((item) => CategoryHeadItem.fromJson(item)).toList();
  }

  // 特惠推荐
  static Future<HotRecommendResult> getHotRecommend() async {
    final data = await Request.get(HttpConstants.HOT_PREFERENCE) as Map;
    return HotRecommendResult.fromJson(data as Map<String, dynamic>);
  }

  // 热榜推荐
  static Future<HotRecommendResult> getInVogueListAPI() async {
    // 返回请求
    return HotRecommendResult.fromJson(
      await Request.get(HttpConstants.IN_VOGUE_LIST),
    );
  }

  // 一站式推荐
  static Future<HotRecommendResult> getOneStopListAPI() async {
    // 返回请求
    return HotRecommendResult.fromJson(
      await Request.get(HttpConstants.ONE_STOP_LIST),
    );
  }

  // 推荐列表
  static Future<List<GoodDetailItem>> getRecommendListAPI(
    Map<String, dynamic> params,
  ) async {
    // 返回请求
    return ((await Request.get(
              HttpConstants.RECOMMEND_LIST,
              queryParameters: params,
            ))
            as List)
        .map((item) {
          return GoodDetailItem.formJSON(item as Map<String, dynamic>);
        })
        .toList();
  }
}
