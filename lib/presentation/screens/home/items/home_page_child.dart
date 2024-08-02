part of '../home_page.dart';

class HomePageChild extends StatelessWidget {
  const HomePageChild({super.key});

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
          body: Column(children: [
            value.isGridView
                ? Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          return const UserGridItem(
                            imageUrl: "https://reqres.in/img/faces/2-image.jpg",
                            firstName: "John",
                            lastName: "Doe",
                            email: "john.doe@example.com",
                          );
                        }))
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 12,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return const UserListItem(
                          imageUrl: "https://reqres.in/img/faces/2-image.jpg",
                          firstName: "John",
                          lastName: "Doe",
                          email: "john.doe@example.com",
                        );
                      },
                    ),
                  ),
          ]),
        );
      },
    );
  }
}
