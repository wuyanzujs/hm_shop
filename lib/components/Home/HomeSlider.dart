import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/types/home.dart';

class HomeSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const HomeSlider({super.key, required this.bannerList});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  // 常量定义
  static const double _searchBarHeight = 50.0;
  static const double _searchBarRadius = 20.0;
  static const double _dotHeight = 6.0;
  static const double _dotWidthNormal = 20.0;
  static const double _dotWidthActive = 40.0;
  static const double _dotMargin = 5.0;
  static const Color _searchBarBgColor = Color.fromRGBO(0, 0, 0, 0.4);
  static const Color _dotInactiveColor = Color.fromRGBO(0, 0, 0, 0.3);

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  Widget _getSlider(double screenWidth) {
    return CarouselSlider(
      carouselController: _carouselController,
      items: widget.bannerList
          .map(
            (e) => Image.network(
              e.url,
              fit: BoxFit.cover,
              width: screenWidth,
              errorBuilder: (context, error, stackTrace) => Container(
                width: screenWidth,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        onPageChanged: (int index, reason) {
          _currentIndexNotifier.value = index;
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            // TODO: 实现搜索功能
          },
          child: Container(
            alignment: Alignment.centerLeft,
            height: _searchBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: _searchBarBgColor,
              borderRadius: BorderRadius.circular(_searchBarRadius),
            ),
            child: const Text(
              "搜索...",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.bannerList.length, (int index) {
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _dotHeight,
                    width: currentIndex == index
                        ? _dotWidthActive
                        : _dotWidthNormal,
                    margin: const EdgeInsets.symmetric(horizontal: _dotMargin),
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.white
                          : _dotInactiveColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [_getSlider(screenWidth), _getSearch(), _getDots()]);
  }
}
