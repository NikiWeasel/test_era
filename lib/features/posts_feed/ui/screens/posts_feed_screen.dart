import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/app/bloc/settings_bloc.dart';
import 'package:test_project/common/domain/entities/post.dart';
import 'package:test_project/features/posts_feed/bloc/posts_bloc.dart';
import 'package:test_project/features/posts_feed/ui/screens/post_details_screen.dart';
import 'package:test_project/features/posts_feed/ui/widgets/list_tile_widget.dart';
import 'package:test_project/features/posts_feed/ui/widgets/search_text_field.dart';

class PostsFeedScreen extends StatefulWidget {
  const PostsFeedScreen({super.key});

  @override
  State<PostsFeedScreen> createState() => _PostsFeedScreenState();
}

class _PostsFeedScreenState extends State<PostsFeedScreen> {
  late bool isDark;

  @override
  void initState() {
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onRefresh() {
      context.read<PostsBloc>().add(FetchPosts());
    }

    Future<void> ss() async {
      onRefresh();
    }

    void pushDetails(Post post) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (con) => PostDetailsScreen(post: post)),
      );
    }

    void onToggleTheme() {
      context.read<SettingsBloc>().add(ToggleTheme());
    }

    void onSearchChanged(String searchString) {
      if (searchString.isEmpty) {
        onRefresh();
      } else {
        context.read<PostsBloc>().add(FilterPosts(searchString));
      }
    }

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<PostsBloc, PostsState>(
          builder: (context, postsState) {
            debugPrint(postsState.toString());
            if (settingsState is SettingsLoaded) {
              isDark = settingsState.isDark;
            }
            return Scaffold(
              appBar: AppBar(
                title: SearchTextField(onChanched: onSearchChanged,),
                actions: [
                  Switch(
                    value: isDark,
                    onChanged: (val) {
                      onToggleTheme();
                    },
                  ),
                ],
              ),
              body: switch (postsState) {
                PostsInitial() => Center(child: CircularProgressIndicator()),
                PostsLoading() => Center(child: CircularProgressIndicator()),
                PostsLoaded() => RefreshIndicator.adaptive(
                  onRefresh: ss,
                  child: ListView.builder(
                    itemCount: postsState.posts.length,
                    itemBuilder: (con, index) {
                      return ListTileWidget(
                        post: postsState.posts[index],
                        onTap: () {
                          pushDetails(postsState.posts[index]);
                        },
                      );
                    },
                  ),
                ),
                PostsError() => Center(child: Text(postsState.errorMsg)),
              },
            );
          },
        );
      },
    );
  }
}
