import 'package:tp_flutter/shared/services/post_data_source/posts_data_source.dart';
import '../../models/post.dart';

class FakePostsDataSource extends PostsDataSource {

  final List<Post> _fakePosts = [
    const Post(id: '1', title: 'Post 1', description: 'Description'),
    const Post(id: '2', title: 'Post 2', description: 'Description'),
    const Post(id: '3', title: 'Post 3', description: 'Description')
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));

    final newId = (_fakePosts.length + 1).toString();
    final newPost = postToAdd.id.isEmpty
        ? postToAdd.copyWith(id: newId)
        : postToAdd;

    _fakePosts.add(newPost);
    return newPost;
  }

  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == newPost.id);

    if (index == -1) {
      throw Exception('Post not found');
    }

    _fakePosts[index] = newPost;
    return newPost;
  }
}