import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_bloc.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_error.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_loaded.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_loading.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_state.dart';
import 'package:tp_flutter/post_screen/posts_create_screen/posts_create_screen.dart';
import 'package:tp_flutter/post_screen/posts_detail_screen/posts_detail_screen.dart';
import 'package:tp_flutter/post_screen/widgets/post_list_item.dart';
import 'package:tp_flutter/shared/models/post.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Les posts')),
      body: BlocListener<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state is PostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur lors du chargement : ${state.error}')),
            );
          }
        },
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is PostLoaded) {
              if (state.posts.isEmpty) {
                return const Center(child: Text('Vous n\'avez rien posté...'));
              }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostListItem(
                    post: post,
                    onTap: () => _openProductDetailScreen(context, post),
                  );
                },
              );
            } else if (state is PostError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('Vous n\'avez rien posté...'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostsCreateScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openProductDetailScreen(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }
}
