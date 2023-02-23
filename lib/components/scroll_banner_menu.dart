import 'dart:developer';

import 'package:flutter/material.dart';

class ScrollBannerMenu extends StatefulWidget {
  const ScrollBannerMenu({super.key});

  @override
  State<ScrollBannerMenu> createState() => _ScrollBannerMenuState();
}

class _ScrollBannerMenuState extends State<ScrollBannerMenu> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  int menuIndex = 0;
  final List<String> items = [
    "Menu 1",
    "Menu 2",
    "Menu 3",
    "Menu 4",
    "Menu 5",
    "Menu 6",
  ];
  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });

      if (_pageController.page!.round() > menuIndex) {
        if (menuIndex < items.length) {
          setState(() {
            menuIndex++;
          });
        }
      }
      if (_pageController.page!.round() < menuIndex) {
        // if (menuIndex > 0) {
        setState(() {
          menuIndex--;
        });
        // }
      }
    });

    _scrollController.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(currentPage.toString()),
        Text(menuIndex.toString()),
        Container(
          margin: const EdgeInsets.only(top: 16),
          // color: Colors.white,
          height: 30,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: items.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    menuIndex = index;
                  });
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.linear,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: menuIndex == index
                          ? Colors.blue[900]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(1000)),
                  margin: const EdgeInsets.only(right: 16),
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Text(items[index]),
                ),
              );
            },
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.width / 2,
            child: PageView.builder(
              controller: _pageController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                );
              },
            ))
      ],
    );
  }
}
