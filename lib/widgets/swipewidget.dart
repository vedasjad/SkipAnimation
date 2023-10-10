import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SwipeWidget extends StatelessWidget {
  const SwipeWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: screenHeight * 0.3,
          width: screenWidth * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors().primaryColor,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.25,
          width: screenWidth * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Title Goes Here!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().primaryColor,
                  fontSize: screenHeight * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "lorem ipsum dorem sip amet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
