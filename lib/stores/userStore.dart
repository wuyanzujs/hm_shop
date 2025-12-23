import 'package:get/get.dart';
import 'package:hm_shop/types/login.dart';

class UserStore extends GetxController {
  var user = UserInfo.fromJSON({}).obs;

  void updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
