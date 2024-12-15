import 'package:tp_flutter/post_screen/post_bloc/post_state/post_state.dart';
import '../../../shared/models/post.dart';

class PostLoaded extends PostsState {
  final List<Post> posts;
  PostLoaded(this.posts);
}