part of '../home_screen.dart';

class HomePageChild extends StatefulWidget {
  const HomePageChild({super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.init();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
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
                      ),
                    ),
            ]),
          ),
        );
      },
    );
  }
}
