import 'package:flutter/material.dart';
import 'package:manajemen_buku_pribadi/database/db_helper.dart';
import 'package:manajemen_buku_pribadi/model/book_model.dart';
import 'package:manajemen_buku_pribadi/screens/books/add_book_page.dart';
import 'package:manajemen_buku_pribadi/screens/books/detail_book_page.dart';
import 'package:manajemen_buku_pribadi/screens/books/edit_book_page.dart';

class ListBookPage extends StatefulWidget {
  const ListBookPage({Key? key}) : super(key: key);

  @override
  State<ListBookPage> createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  late Future<List<BookModel>> books;

  @override
  void initState() {
    super.initState();
    _loadBooks(); // Load the books when the page is initialized
  }

  void _loadBooks() {
    setState(() {
      books = DbHelper.getBooks(); // Fetch books from the database
    });
  }

  Future<void> _deleteBook(int bookId) async {
    await DbHelper.deleteBook(bookId); // Delete the book from the database
    _loadBooks(); // Refresh the list of books
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Books'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(onBookAdded: _loadBooks),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BookModel>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books available.'));
          } else {
            List<BookModel> booksList = snapshot.data!;
            return ListView.builder(
              itemCount: booksList.length,
              itemBuilder: (context, index) {
                BookModel book = booksList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to BookDetailPage when a book is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(book: book),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Navigate to the EditBookPage when the edit icon is pressed
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(
                                  book: book,
                                  onBookEdited:
                                      _loadBooks, // Refresh the list after editing
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteBook(book.id!); // Delete the book
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
