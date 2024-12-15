import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/post.dart';
import '../post_bloc/post_bloc.dart';
import '../post_bloc/post_event.dart';

class PostDetailScreen extends StatefulWidget {
  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, 'postDetail', arguments: post);
  }
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController =
        TextEditingController(text: widget.post.description);
  }

  void _updatePost() {
    if (_formKey.currentState!.validate()) {
      final updatedPost = widget.post.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
      );
      context.read<PostsBloc>().add(UpdatePostEvent(updatedPost));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails du post")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Titre"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Le titre est obligatoire";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "La description est obligatoire";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updatePost,
                child: const Text("Modifier le post"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
