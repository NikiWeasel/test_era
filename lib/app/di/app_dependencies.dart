import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_project/features/posts_feed/data/repositories/posts_repository.dart';
import 'package:test_project/features/posts_feed/data/services/rest_client.dart';
import 'package:test_project/features/posts_feed/domain/repositories/i_posts_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Dio
  getIt
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
        ),
      ),
    )
    // SharedPreferences
    // final prefs = await SharedPreferences.getInstance();
    // getIt.registerLazySingleton(() => prefs);
    // Retrofit
    ..registerLazySingleton<RestClient>(() => RestClient(getIt<Dio>()))
    //repositories
    ..registerLazySingleton<IPostsRepository>(
      () => PostsRepository(getIt<RestClient>()),
    );

  // ..registerLazySingleton<ISettingsRepository>(
  // () => SettingsRepository(getIt<SettingsDAO>()),
  // );
}
