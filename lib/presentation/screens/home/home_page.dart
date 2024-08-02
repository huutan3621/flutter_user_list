import 'package:flutter/material.dart';
import 'package:flutter_user_list/presentation/provider/home/home_provider.dart';
import 'package:flutter_user_list/presentation/screens/widgets/user_grid_item.dart';
import 'package:flutter_user_list/presentation/screens/widgets/user_list_item.dart';
import 'package:provider/provider.dart';

part 'items/home_page_child.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const HomePageChild(),
    );
  }
}
