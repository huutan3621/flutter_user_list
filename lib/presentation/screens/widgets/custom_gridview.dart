import 'package:flutter/material.dart';

class CustomGridView extends StatefulWidget {
  final int itemCount;
  final bool? shrinkWrap;
  final SliverGridDelegate gridDelegate;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool enableLoadMore;
  final Function()? onLoadMore;

  const CustomGridView({
    super.key,
    required this.itemCount,
    this.shrinkWrap = false,
    this.gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    required this.itemBuilder,
    required this.enableLoadMore,
    this.onLoadMore,
  });

  @override
  _CustomGridViewState createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  final ScrollController _scrollController = ScrollController();
  bool isLoadingPosts = false;

  @override
  void initState() {
    super.initState();

    // Add a listener to the scroll controller to detect when the user has reached the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // The user has reached the end of the list, so load more posts
        _loadMorePosts();
      }
    });
  }

  @override
  void dispose() {
    // Dispose the scroll controller when the widget is removed from the widget tree
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 3),
        gridDelegate: widget.gridDelegate,
        itemCount: widget
            .itemCount, // Add 1 item for the progress indicator if isLoadingPosts is true
        itemBuilder: widget.itemCount > 0
            ? widget.itemBuilder
            : (BuildContext context, int index) {
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.error),
                          SizedBox(
                            height: 16,
                          ),
                          Text("Không có dữ liệu",
                              style: TextStyle(fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                );
                return null;
              });
  }

  // Load more posts
  void _loadMorePosts() async {
    if (!isLoadingPosts) {
      setState(() {
        isLoadingPosts = true;
      });

      widget.onLoadMore;

      setState(() {
        isLoadingPosts = false;
      });
    }
  }
}
