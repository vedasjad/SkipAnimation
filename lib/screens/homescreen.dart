import 'package:flutter/material.dart';
import 'package:skipanimation/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/swipewidget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  PageController pageController = PageController(initialPage: 0);
  bool isLastPage = false;
  bool hasSkipped = false;
  bool didClickSkip = false;

  void returnToFirst() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  void skipToLast() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
    pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: (isLastPage)
          ? const SizedBox()
          : FloatingActionButton(
              backgroundColor: AppColors().primaryColor,
              shape: const CircleBorder(),
              onPressed: () {
                if (pageController.offset < screenWidth) {
                  pageController.animateTo(
                    screenWidth,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                  );
                } else if (pageController.offset < screenWidth * 2) {
                  pageController.animateTo(
                    screenWidth * 2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                  );
                } else if (pageController.offset < screenWidth * 3) {
                  pageController.animateTo(
                    screenWidth * 3,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                  );
                } else if (pageController.offset < screenWidth * 4) {
                  didClickSkip = false;
                  returnToFirst();
                }
              },
              child: Icon(
                (!isLastPage)
                    ? Icons.arrow_forward_rounded
                    : Icons.refresh_rounded,
                color: Colors.white,
              ),
            ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0, top: 25),
            child: GestureDetector(
              onTap: () {
                if (!isLastPage) {
                  setState(() {
                    didClickSkip = true;
                  });
                  skipToLast();
                }
              },
              child: Text(
                isLastPage ? '' : 'Skip',
                style: TextStyle(
                  color: AppColors().primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: SizedBox(
                  height: screenHeight * 0.7,
                  child: PageView.builder(
                    itemCount: 4,
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        isLastPage = (index == 3) ? true : false;
                        hasSkipped = (index < 3) ? false : didClickSkip;
                      });
                    },
                    itemBuilder: (BuildContext context, index) {
                      return index == 3
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () => returnToFirst(),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      AppColors().primaryColor,
                                    ),
                                  ),
                                  child: const Text(
                                    'Return',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SwipeWidget(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                            );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: hasSkipped
                    ? const Text(
                        'You Skipped all pages',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    : const SizedBox(),
              ),
              if (!isLastPage)
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: SmoothPageIndicator(
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    controller: pageController,
                    count: 4,
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      offset: 12,
                      spacing: 12,
                      dotColor: AppColors().primaryColor.withOpacity(0.3),
                      activeDotColor: AppColors().primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
