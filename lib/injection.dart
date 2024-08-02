part of 'main.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<UserUsecase>(UserUsecase(UserRepositoryImpl()));
}
