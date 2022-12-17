import 'package:flutter/material.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/perspective_items.dart';
import 'package:flutter_ui_radio/pages/stations_page/_widgets/station_card/station_card.dart';

class PerspectiveListView extends StatefulWidget {
  const PerspectiveListView({
    super.key,
    required this.itemExtent,
    required this.visualizedCount,
    this.initialIndex = 0,
    this.padding = EdgeInsets.zero,
    required this.children,
    required this.onTapFrontItem,
    required this.onChangeItem,
  });

  final double itemExtent;
  final int visualizedCount;
  final int initialIndex;
  final EdgeInsetsGeometry padding;
  final List<StationCard> children;
  final ValueChanged<int>? onTapFrontItem;
  final ValueChanged<int>? onChangeItem;

  @override
  State<PerspectiveListView> createState() => _PerspectiveListViewState();
}

class _PerspectiveListViewState extends State<PerspectiveListView> {
  late PageController _pageController;
  late double _pagePersent;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pagePersent = 0.0;

    _pageController = PageController(
      initialPage: _currentIndex,
      viewportFraction: .33,
    );

    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    _currentIndex = _pageController.page!.floor();
    _pagePersent = (_pageController.page! - _currentIndex).abs();
    setState(() {});
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_pageListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) {
          final height = constraints.maxHeight;
          return Stack(
            children: [
              Padding(
                padding: widget.padding,
                child: PerspectiveItems(
                  visualizedCount: widget.visualizedCount - 1,
                  currentIndex: _currentIndex,
                  itemHeight: widget.itemExtent,
                  pagePersent: _pagePersent,
                  children: widget.children,
                ),
              ),
              // Empty PageView
              PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  if (widget.onChangeItem != null) {
                    widget.onChangeItem!(value);
                  }
                },
                itemCount: widget.children.length,
                itemBuilder: (context, index) => const SizedBox(),
              ),
              // onTap
              Positioned.fill(
                top: height - widget.itemExtent,
                child: GestureDetector(
                  onTap: () {
                    if (widget.onTapFrontItem != null) {
                      widget.onTapFrontItem!(_currentIndex);
                    }
                  },
                ),
              ),
            ],
          );
        },
      );
}
