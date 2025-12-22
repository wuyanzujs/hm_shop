import 'package:flutter/material.dart';
import 'package:hm_shop/types/home.dart';

class Category extends StatefulWidget {
  final List<CategoryHeadItem> categoryList;
  const Category({required this.categoryList, super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // 屏蔽外层CustomScrollView的垂直滚动, 才能进行ListView的横向滚动
        physics: ClampingScrollPhysics(),
        itemCount: widget.categoryList.length,
        itemBuilder: (content, index) {
          final category = widget.categoryList[index];
          return Container(
            height: 80,
            width: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 230, 230),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture, width: 40, height: 40),
                Text(category.name, style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
