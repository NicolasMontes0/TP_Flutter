import 'package:tp_flutter/post_screen/post_bloc/post_state/post_state.dart';

class PostError extends PostsState {
  final String error;
  PostError(this.error);
}