import '../../shared/models/post.dart';

abstract class PostsEvent {}

class LoadPostsEvent extends PostsEvent {}

class CreatePostEvent extends PostsEvent {
  final Post post;
  CreatePostEvent(this.post);
}

class UpdatePostEvent extends PostsEvent {
  final Post post;
  UpdatePostEvent(this.post);
}
