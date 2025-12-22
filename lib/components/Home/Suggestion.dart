import 'package:flutter/material.dart';
import 'package:hm_shop/types/home.dart';

class Suggestion extends StatefulWidget {
  final HotRecommendResult hotRecommendData;
  const Suggestion({super.key, required this.hotRecommendData});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  List<GoodsItem> _getDisplayItems() {
    if (widget.hotRecommendData.subTypes.isEmpty) return [];
    return widget.hotRecommendData.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  List<Widget> _getDisplayChildren() {
    List<GoodsItem> list = _getDisplayItems();
    return List.generate(list.length, (index) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'lib/assets/home_cmd_inner.png',
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                );
              },
              list[index].picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 52, 38),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Text(
              "¥${list[index].price}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  // 构建头部
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "爆款推荐",
          style: TextStyle(
            color: const Color.fromARGB(255, 171, 61, 51),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精品省攻略",
          style: TextStyle(
            color: const Color.fromARGB(255, 170, 97, 90),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 构建左侧
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('lib/assets/home_cmd_inner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
          image: DecorationImage(
            image: AssetImage('lib/assets/home_cmd_sm.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getDisplayChildren(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
