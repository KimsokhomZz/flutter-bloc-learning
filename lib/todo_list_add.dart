import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter_bloc/cubit/todo_cubit.dart';
import 'package:learning_flutter_bloc/model/todolist_model.dart';

class TodoListAdd extends StatefulWidget {
  final TodoListModel? todo; // null for add, not null for edit

  const TodoListAdd({super.key, this.todo});

  @override
  State<TodoListAdd> createState() => _TodoListAddState();
}

class _TodoListAddState extends State<TodoListAdd> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo?.title ?? '';
    _descriptionController.text = widget.todo?.description ?? '';
    _isDone = widget.todo?.isDone ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      final todoCubit = BlocProvider.of<TodoCubit>(context);
      final isEditMode = widget.todo != null;
      // create a todo instance
      final todo = TodoListModel(
        id: isEditMode ? widget.todo!.id : null,
        title: _titleController.text.trim(),
        description:
            _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
        isDone: _isDone,
        createdAt: isEditMode ? widget.todo!.createdAt : null,
      );
      if (isEditMode) {
        // Update existing todo
        todoCubit.updateTodo(todo);
      } else {
        // Add new todo
        todoCubit.addTodo(todo);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'What do you want to do?',
                    icon: Icon(Icons.note_alt_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Optional',
                    icon: Icon(Icons.description),
                  ),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Is Done?'),
                  value: _isDone,
                  onChanged: (value) {
                    setState(() {
                      _isDone = value ?? false;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: onSubmitForm,
                    child: Text('Add Todo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
