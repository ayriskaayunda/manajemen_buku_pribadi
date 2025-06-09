import 'package:flutter/material.dart';
import 'package:manajemen_buku_pribadi/database/db_helper.dart';
import 'package:manajemen_buku_pribadi/model/book_model.dart';

class AddBookPage extends StatefulWidget {
  final Function onBookAdded; // Callback to refresh the book list

  const AddBookPage({Key? key, required this.onBookAdded}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Book')),
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
                    BookModel newBook = BookModel(
                      title: titleController.text,
                      author: authorController.text,
                      description: descriptionController.text,
                      genre: genreController.text,
                    );
                    await DbHelper.addBook(book: newBook);

                    // Call the callback to reload the book list
                    widget.onBookAdded();

                    Navigator.pop(context); // Go back to the list of books
                  }
                },
                child: Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
