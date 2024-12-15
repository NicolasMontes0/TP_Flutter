import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_bloc.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_event.dart';
import 'package:tp_flutter/post_screen/posts_screen.dart';
import 'package:tp_flutter/shared/services/post_data_source/fake_posts_data_source.dart';
import 'shared/services/post_repository/post_repository.dart';

void main() {
  final postsRepository = PostsRepository(FakePostsDataSource());
  runApp(MyApp(postsRepository: postsRepository));
}

class MyApp extends StatelessWidget {
  final PostsRepository postsRepository;
  const MyApp({super.key, required this.postsRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsBloc(postsRepository)..add(LoadPostsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'TP Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const PostScreen(),
      ),
    );
  }
}
