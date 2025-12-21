import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/types/home.dart';
import 'package:hm_shop/utils/Request.dart';

class HomeApi {
  static Future<List<BannerItem>> getBannerList() async {
    final data = await Request().get(HttpConstants.BANNER_PATH) as List;
    return data.map((item) => BannerItem.fromJson(item)).toList();
  }
}
