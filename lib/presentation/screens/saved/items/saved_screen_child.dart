part of '../saved_screen.dart';

class SavedScreenChild extends StatefulWidget {
  const SavedScreenChild({super.key});

  @override
  State<SavedScreenChild> createState() => _SavedScreenChildState();
}

class _SavedScreenChildState extends State<SavedScreenChild> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SavedProvider()..fetchFavorites(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved Users'),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<SavedProvider>(
          builder: (context, savedProvider, child) {
            return RefreshIndicator(
              onRefresh: () async {
                await savedProvider.fetchFavorites();
              },
              child: savedProvider.favorites.isEmpty
                  ? const Center(child: Text('No saved users yet.'))
                  : ListView.builder(
                      itemCount: savedProvider.favorites.length,
                      itemBuilder: (context, index) {
                        final user = savedProvider.favorites[index];
                        return UserListItem(
                          user: user,
                          onFavoriteToggle: () {
                            savedProvider
                                .toggleFavorite(savedProvider.favorites[index]);
                            setState(() {});
                          },
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
