import '/constants/constant.dart';
import 'package:flutter/material.dart';

class BuildDots extends StatelessWidget {
  const BuildDots({super.key, required this.list, required this.index});

  final List list;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: list
          .map(
            (e) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              width: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  4,
                ),
                color: list.indexOf(e) == index ? baseColor : Colors.grey,
              ),
            ),
          )
          .toList(),
    );
  }
}
