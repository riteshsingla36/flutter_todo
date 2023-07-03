import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/datamodels/todo.dart';
import 'package:todo_app/ui/views/editTodo_viewmodel.dart';

class EditTodoView extends StatelessWidget {
  EditTodoView({Key? key, required this.todo}) : super(key: key);
  final Todo todo;
  late final _titleController = TextEditingController(text: todo.title);
  late final _descriptionController = TextEditingController(text: todo.description);

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<EditTodoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white, size:30),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          title: const Text(
            "Edit Todo",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          actions: [
            InkWell(
              onTap: () => model.updateEdit(),
              child: Icon(
                Icons.edit,
                color: model.isEditEnabled ? Colors.green : Colors.white,
              )
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xff252041),
                      Color(0xff1d1e26)
                    ]
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  label("Task Title",context),
                  const SizedBox(
                    height: 12,
                  ),
                  title(context, model),
                  const SizedBox(
                    height: 30,
                  ),
                  label("Task Type",context),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      typeChip("Important", 0xffabd433, context, model),
                      const SizedBox(
                        width: 20,
                      ),
                      typeChip("Planned", 0xffff33d4, context, model)
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  label("Description", context),
                  const SizedBox(
                    height: 12,
                  ),
                  description(context, model),
                  const SizedBox(
                    height: 25,
                  ),
                  label("Category", context),
                  const SizedBox(
                    height: 12,
                  ),
                  Wrap(
                    runSpacing: 20,
                    children: [
                      categoryChip("Food", 0xffff6d6e, context, model),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryChip("Work", 0xfff29732, context, model),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryChip("Work out", 0xff6557ff, context, model),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryChip("Shopping", 0xff2bc8d9, context, model)
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  button(context, model)
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => EditTodoViewModel(todo),
    );
  }

  Widget button(BuildContext context, EditTodoViewModel model) {
    return InkWell(
      onTap: () => model.isEditEnabled ? model.updateTodo(_titleController.text.trim(), _descriptionController.text.trim()) : null,
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: model.isEditEnabled ? LinearGradient(
                colors: [
                  Color(0xff8a32f1),
                  Color(0xffad32f9)
                ]
            ) : LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white
                ]
            )
        ),
        child: Center(
          child: model.isLoading ? CircularProgressIndicator(
            color: Colors.white,
          ) : Text(
            "Update Todo",
            style: TextStyle(
                color: model.isEditEnabled ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),
          ),
        ),
      ),
    );
  }

  Widget description(BuildContext context, EditTodoViewModel model) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color(0xff2a2e3d),
          borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        enabled: model.isEditEnabled,
        controller: _descriptionController,
        maxLines: null,
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 17
        ),
        decoration: const InputDecoration(
            hintText: "Task Description...",
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 17
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
                left: 20,
                right: 20
            )
        ),
      ),
    );
  }

  Widget typeChip(String text, int color, BuildContext context, EditTodoViewModel model) {
    return InkWell(
      onTap: () => model.isEditEnabled ? model.updateType(text) : null,
      child: Chip(
        label: Text(
          text,
          style: TextStyle(
              color: model.type == text ? Colors.black :Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        backgroundColor: model.type == text ? Colors.white : Color(color),
        labelPadding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 3.8
        ),
      ),
    );
  }

  Widget categoryChip(String text, int color, BuildContext context, EditTodoViewModel model) {
    return InkWell(
      onTap: () => model.isEditEnabled ? model.updateCategory(text): null,
      child: Chip(
        label: Text(
          text,
          style: TextStyle(
              color: model.category == text ? Colors.black :Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        backgroundColor: model.category == text ? Colors.white : Color(color),
        labelPadding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 3.8
        ),
      ),
    );
  }

  Widget title(BuildContext context, EditTodoViewModel model) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: const Color(0xff2a2e3d),
          borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        enabled: model.isEditEnabled,
        controller: _titleController,
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 17
        ),
        decoration: const InputDecoration(
            hintText: "Task Title...",
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 17
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
                left: 20,
                right: 20
            )
        ),
      ),
    );
  }

  Widget label(String labelText, BuildContext context) {
    return Text(
      labelText,
      style: const TextStyle(
          fontSize: 17,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    );
  }
}