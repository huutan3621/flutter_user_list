import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum LoadMoreType { isLoading, idle }

// ignore: must_be_immutable
class ListWidget extends StatefulWidget {
  // Required, to know number of items
  int itemCount;

  /// Required, this function to render item of list
  /// Ex: (context, index) => Container(child:Text(data[index].title),);
  Widget Function(BuildContext context, int index) itemBuilder;

  /// this function will be call when list scroll to bottom
  /// use with enableLoadMore = true
  Future<void> Function()? onLoadMore;

  // detect whenever list should load more
  bool enableLoadMore;

  /// Direction of list, for show list vertical or horizontal
  /// Default: vertical
  final Axis? scrollDirection;

  /// use when we want custom scroll
  /// default: AlwaysScrollableScrollPhysics(),
  final ScrollPhysics? physics;

  /// render header of list
  final Widget? listHeaderWidget;

  /// Decoration container parent, such as border, color...
  final Decoration? decoration;

  /// padding of list
  final EdgeInsetsGeometry? padding;

  /// ///distance to empty
  final EdgeInsetsGeometry? paddingEmpty;

  /// margin of list
  final EdgeInsetsGeometry? margin;

  /// render when list is empty
  /// default: Text("No data")
  final Widget? emptyWidget;

  /// Render bottom list
  /// default: Loading for load more
  final Widget? listBottomWidget;

  ///for information:https://api.flutter.dev/flutter/widgets/ScrollView/shrinkWrap.html
  bool shrinkWrap;

  /// True when we want list render from bottom to top
  /// default: false
  bool reverse;

  /// visibility
  bool visibility;

  /// Listener when scroll
  final void Function(ScrollController)? scrollListener;

  ///Use when we want control list outside this widget
  final ScrollController? scrollController;

  ///distance to load more
  final double distanceLoading;

  ListWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onLoadMore,
    this.enableLoadMore = false,
    this.scrollDirection = Axis.vertical,
    this.physics =
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    this.listHeaderWidget,
    this.decoration,
    this.padding,
    this.paddingEmpty,
    this.margin,
    this.shrinkWrap = true,
    this.reverse = false,
    this.visibility = true,
    this.scrollListener,
    this.listBottomWidget,
    this.scrollController,
    this.emptyWidget,
    this.distanceLoading = 500,
  });

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  ScrollController controller = ScrollController();
  final GlobalKey _keyHeader = GlobalKey();
  var headerHeight = 0.0;
  var loadMoreType = LoadMoreType.idle;

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    if (widget.scrollListener != null) {
      controller.addListener(() {
        widget.scrollListener!(controller);
      });
    }
    if (widget.scrollController != null) {
      controller = widget.scrollController!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        headerHeight = _keyHeader.currentContext!.size!.height;
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visibility,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var maxHeight = constraints.maxHeight;
          return ListView(
            controller: controller,
            physics: widget.physics,
            cacheExtent: 1000.0,
            shrinkWrap: widget.shrinkWrap,
            reverse: widget.reverse,
            children: [
              renderListHeaderWidget(),
              renderListBodyWidget(maxHeight),
              widget.listBottomWidget ?? renderListFooterWidget(),
            ],
          );
        },
      ),
    );
  }

  /// Render list body widget
  renderListBodyWidget(double maxHeight) {
    // final controller = context.watch<AppCubit>();
    // final theme = controller.state.theme;
    if (widget.itemCount > 0) {
      return Container(
        padding: widget.padding,
        margin: widget.margin,
        decoration: widget.decoration,
        child: renderChild(),
      );
    } else {
      return Container(
        constraints: BoxConstraints(
          minHeight: maxHeight - headerHeight,
          maxHeight: maxHeight - headerHeight,
        ),
        padding:
            widget.paddingEmpty ?? const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.emptyWidget ??
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    SizedBox(
                      height: 16,
                    ),
                    Text("Không có dữ liệu", style: TextStyle(fontSize: 16)),
                  ],
                )
          ],
        ),
      );
    }
  }

  renderChild() {
    return ListView.builder(
      scrollDirection: widget.scrollDirection!,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        return widget.itemBuilder(context, index);
      },
      itemCount: widget.itemCount,
    );
  }

  renderListHeaderWidget() {
    return Container(
      key: _keyHeader,
      child: widget.listHeaderWidget ?? Container(),
    );
  }

  renderListFooterWidget() {
    return widget.enableLoadMore
        ? Container(
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }

  /// Scroll listener
  void scrollListener() {
    if (controller.position.userScrollDirection == ScrollDirection.reverse &&
        controller.position.extentAfter < widget.distanceLoading &&
        widget.enableLoadMore &&
        loadMoreType == LoadMoreType.idle) {
      onLoadMore();
    }
  }

  /// On load more
  Future<void> onLoadMore() async {
    loadMoreType = LoadMoreType.isLoading;
    await widget.onLoadMore!();
    loadMoreType = LoadMoreType.idle;
  }
}
