import 'package:tp_flutter/shared/models/post.dart';
import 'package:tp_flutter/shared/services/post_data_source/posts_data_source.dart';

class PostsRepository {

  final PostsDataSource postsDataSource;

  PostsRepository(this.postsDataSource);

  Future<List<Post>> getPosts() => postsDataSource.getAllPosts();
  Future<Post> createPost(Post post) => postsDataSource.createPost(post);
  Future<Post> updatePost(Post post) => postsDataSource.updatePost(post);
}