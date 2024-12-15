import 'package:bloc/bloc.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_error.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_init.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_loaded.dart';
import 'package:tp_flutter/post_screen/post_bloc/post_state/post_loading.dart';
import '../../shared/services/post_repository/post_repository.dart';
import 'post_event.dart';
import 'post_state/post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;

  PostsBloc(this.repository) : super(PostInitial()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.getPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<CreatePostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        await repository.createPost(event.post);
        final posts = await repository.getPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(PostLoading());
      try {
        await repository.updatePost(event.post);
        final posts = await repository.getPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
