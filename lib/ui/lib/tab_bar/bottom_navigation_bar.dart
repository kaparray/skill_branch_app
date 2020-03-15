import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:skill_branch_flutter/redux/app/app_state.dart';

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key key,
    this.showElevation = true,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
    this.curve = Curves.linear,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onItemSelected != null);
    assert(curve != null);
  }

  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null) ? Theme.of(context).bottomAppBarColor : backgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: StoreBuilder(
                  builder: (BuildContext context, Store<AppState> activeTab) {
                    if (index == activeTab.state.tabState.currentTab) {
                      return _ItemWidget(
                        item: item,
                        isSelected: true,
                        backgroundColor: bgColor,
                        itemCornerRadius: itemCornerRadius,
                        animationDuration: animationDuration,
                        curve: curve,
                      );
                    }
                    return _ItemWidget(
                      item: item,
                      isSelected: false,
                      backgroundColor: bgColor,
                      itemCornerRadius: itemCornerRadius,
                      animationDuration: animationDuration,
                      curve: curve,
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    Key key,
    @required this.item,
    @required this.isSelected,
    @required this.backgroundColor,
    @required this.animationDuration,
    @required this.itemCornerRadius,
    this.curve = Curves.linear,
  })  : assert(isSelected != null),
        assert(item != null),
        assert(backgroundColor != null),
        assert(animationDuration != null),
        assert(itemCornerRadius != null),
        assert(curve != null),
        super(key: key);

  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isSelected ? 150 : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      height: double.maxFinite,
      duration: animationDuration,
      curve: curve,
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.circular(itemCornerRadius),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: isSelected ? 150 : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                item.asset,
                color: isSelected ? item.activeColor : item.inactiveColor,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: isSelected ? item.activeColor : item.inactiveColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    textAlign: item.textAlign,
                    child: item.title,
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

class BottomNavyBarItem {
  BottomNavyBarItem({
    @required this.asset,
    @required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  }) {
    assert(asset != null && asset.isNotEmpty);
    assert(title != null);
  }

  final String asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}
