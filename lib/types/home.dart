class BannerItem {
  String id;
  String url;
  BannerItem({required this.id, required this.url});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'].toString(), url: json['imgUrl']);
  }
}
