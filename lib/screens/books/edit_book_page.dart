import 'package:flutter/material.dart';
import 'package:manajemen_buku_pribadi/database/db_helper.dart';
import 'package:manajemen_buku_pribadi/model/book_model.dart';

class EditBookPage extends StatefulWidget {
  final BookModel book;
  final Function onBookEdited;

  const EditBookPage({
    super.key,
    required this.book,
    required this.onBookEdited,
  });

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.book.title;
    authorController.text = widget.book.author;
    descriptionController.text = widget.book.description;
    genreController.text = widget.book.genre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
        backgroundColor: const Color.fromARGB(255, 129, 104, 95),
      ),
      backgroundColor: const Color.fromARGB(255, 241, 220, 213),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Book Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: genreController,
                decoration: InputDecoration(labelText: 'Genre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a genre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    BookModel updatedBook = BookModel(
                      id: widget.book.id,
                      title: titleController.text,
                      author: authorController.text,
                      description: descriptionController.text,
                      genre: genreController.text,
                    );
                    await DbHelper.editBook(book: updatedBook);

                    widget.onBookEdited(); // Refresh the list after editing
                    Navigator.pop(context); // Go back to the list of books
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
