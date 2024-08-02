part of '../home_screen.dart';

class HomeScreenChild extends StatefulWidget {
  const HomeScreenChild({super.key});

  @override
  State<HomeScreenChild> createState() => _HomeScreenChildState();
}

class _HomeScreenChildState extends State<HomeScreenChild> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("HomePage"),
            actions: [
              IconButton(
                  onPressed: () {
                    value.changeView(value.isGridView);
                  },
                  icon: Icon(value.isGridView ? Icons.grid_view : Icons.list))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await value.onRefresh();
            },
            child: Column(children: [
              if (child != null) child,
              value.isGridView
                  ? Expanded(
                      child: CustomGridView(
                      itemCount: value.userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UserGridItem(
                          imageUrl: value.userList[index].avatar,
                          firstName: value.userList[index].firstName,
                          lastName: value.userList[index].lastName,
                          email: value.userList[index].email,
                        );
                      },
                      enableLoadMore: value.enableLoadMore,
                      onLoadMore: () async {
                        value.onLoadMore();
                      },
                    ))
                  : Expanded(
                      child: ListWidget(
                        itemCount: value.userList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserListItem(
                            user: value.userList[index],
                            onFavoriteToggle: () {
                              value.toggleFavorite(value.userList[index]);
                              setState(() {});
                            },
                          );
                        },
                        enableLoadMore: value.enableLoadMore,
                        onLoadMore: () async {
                          value.onLoadMore();
                        },
                      ),
                    ),
            ]),
          ),
        );
      },
    );
  }
}
