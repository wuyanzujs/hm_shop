import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/types/login.dart';
import 'package:hm_shop/utils/Request.dart';

class LoginApi {
  static Future<UserInfo> login(Map<String, dynamic> params) async {
    return UserInfo.fromJSON(
      await Request.post(HttpConstants.LOGIN, data: params),
    );
  }
}
