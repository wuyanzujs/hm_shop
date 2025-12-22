class BannerItem {
  String id;
  String url;
  BannerItem({required this.id, required this.url});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'], url: json['imgUrl']);
  }
}

class CategoryHeadItem {
  String id;
  String name;
  String picture;
  List<CategoryHeadItem>? children;
  CategoryHeadItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  factory CategoryHeadItem.fromJson(Map<String, dynamic> json) {
    return CategoryHeadItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: json['children'] != null
          ? (json['children'] as List)
                .map((i) => CategoryHeadItem.fromJson(i))
                .toList()
          : null,
    );
  }
}

class HotRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;

  HotRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory HotRecommendResult.fromJson(Map<String, dynamic> json) {
    return HotRecommendResult(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      subTypes: (json['subTypes'] as List? ?? [])
          .map((i) => SubType.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      goodsItems: GoodsItems.fromJson(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'].toInt(),
      pageSize: json['pageSize'],
      pages: json['pages'].toInt(),
      page: json['page'],
      items: (json['items'] as List? ?? [])
          .map((i) => GoodsItem.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price']?.toString() ?? '0',
      picture: json['picture'] ?? '',
      orderNum: json['orderNum'] ?? 0,
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
