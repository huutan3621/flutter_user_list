import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_user_list/core/network/connectivity.dart';
import 'package:flutter_user_list/core/theme/app_color.dart';
import 'package:flutter_user_list/data/repositories/user_repository_impl.dart';
import 'package:flutter_user_list/domain/repositories/user/user_repository.dart';
import 'package:flutter_user_list/domain/usecases/user/user_usecase.dart';
import 'package:flutter_user_list/router.dart';
import 'package:flutter_user_list/core/services/dio_services.dart';
import 'package:get_it/get_it.dart';

part 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await init();
  initNoInternetListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.light().primary,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.dark().primary,
      ),
      themeMode: ThemeMode.system,
      onGenerateRoute: AppNavigator.generateRoute,
      initialRoute: RouteNames.splashScreen,
      navigatorKey: AppNavigator.navigatorKey,
    );
  }
}
