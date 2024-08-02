import 'package:flutter/material.dart';
import 'package:flutter_user_list/presentation/provider/home/home_provider.dart';
import 'package:flutter_user_list/presentation/provider/saved/saved_provider.dart';
import 'package:flutter_user_list/presentation/screens/widgets/user_list_item.dart';
import 'package:provider/provider.dart';

part 'items/saved_screen_child.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SavedProvider(),
      child: const SavedScreenChild(),
    );
  }
}
