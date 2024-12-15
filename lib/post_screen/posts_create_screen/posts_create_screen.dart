import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/post.dart';
import '../post_bloc/post_bloc.dart';
import '../post_bloc/post_event.dart';

class PostsCreateScreen extends StatefulWidget {
  const PostsCreateScreen({super.key});

  @override
  _PostsCreateScreenState createState() => _PostsCreateScreenState();
}

class _PostsCreateScreenState extends State<PostsCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _createPost() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
      );
      context.read<PostsBloc>().add(CreatePostEvent(newPost));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouveau post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                onPressed: _createPost,
                child: const Text("Créer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
