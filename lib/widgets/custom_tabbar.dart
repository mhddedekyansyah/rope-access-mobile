import 'package:flutter/material.dart';
import 'package:rope_access/theme.dart';

typedef SelectTab = Function(int index);

class CustomTabbar extends StatelessWidget {
  final List<String> titles;
  final int selectedIndex;
  final SelectTab selectTab;

  const CustomTabbar(
      {super.key,
      required this.titles,
      required this.selectedIndex,
      required this.selectTab});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1,
              color: AppColors.secondary,
            ),
          ),
          ListView(
              primary: false,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: titles
                  .map((e) => Padding(
                        padding: EdgeInsets.only(
                            left: AppSpacer.defaultPadding,
                            top: AppSpacer.defaultPadding),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectTab(titles.indexOf(e));
                              },
                              child: Text(
                                e,
                                style: AppTextStyle.primaryStyle.copyWith(
                                    color: selectedIndex == titles.indexOf(e)
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: selectedIndex == titles.indexOf(e)
                                      ? AppColors.purple
                                      : Colors.transparent),
                            )
                          ],
                        ),
                      ))
                  .toList())
        ],
      ),
    );
  }
}
