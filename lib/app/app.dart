import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/app/bloc/settings_bloc.dart';
import 'package:test_project/app/di/app_dependencies.dart';
import 'package:test_project/features/posts_feed/bloc/posts_bloc.dart';
import 'package:test_project/features/posts_feed/domain/repositories/i_posts_repository.dart';
import 'package:test_project/features/posts_feed/ui/screens/posts_feed_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsBloc()),
        BlocProvider(
          create: (context) =>
              PostsBloc(getIt<IPostsRepository>())..add(FetchPosts()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          if (settingsState is SettingsLoaded) {
            return MaterialApp(
              theme: settingsState.isDark
                  ? ThemeData.dark()
                  : ThemeData.light(),
              home: PostsFeedScreen(),
            );
          }

          return MaterialApp(theme: ThemeData.light(), home: PostsFeedScreen());
        },
      ),
    );
  }
}
