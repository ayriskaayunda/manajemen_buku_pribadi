import 'package:flutter/material.dart';
import 'package:manajemen_buku_pribadi/database/db_helper.dart';
import 'package:manajemen_buku_pribadi/model/book_model.dart';
import 'package:manajemen_buku_pribadi/screens/auth/login_screen.dart';
import 'package:manajemen_buku_pribadi/screens/books/add_book_page.dart';
import 'package:manajemen_buku_pribadi/screens/books/detail_book_page.dart';
import 'package:manajemen_buku_pribadi/screens/books/edit_book_page.dart';
import 'package:manajemen_buku_pribadi/screens/books/profile_page.dart';

class ListBookPage extends StatefulWidget {
  const ListBookPage({super.key});

  @override
  State<ListBookPage> createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  late Future<List<BookModel>> books;
  int selectedIndex = 0; // 0 = List Buku, 1 = Profil

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() {
    setState(() {
      books = DbHelper.getBooks();
    });
  }

  void _onDrawerItemTapped(int index) {
    Navigator.pop(context); // Menutup drawer
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> _deleteBook(int bookId) async {
    await DbHelper.deleteBook(bookId); // Delete the book from the database
    _loadBooks(); // Refresh the list of books
  }

  Widget _buildBookListView() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FutureBuilder<List<BookModel>>(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(book: book),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 223, 208, 203),
                    elevation: 10,
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        book.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        book.author,
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBookPage(
                                    book: book,
                                    onBookEdited: _loadBooks,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              _deleteBook(book.id!);
                            },
                          ),
                        ],
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 240, 236, 234),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 143, 124, 117),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.brown[700],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Ayriska ayunda',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 61, 59, 59),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "All about Butterfly",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 194, 189, 188),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.book, color: Colors.brown[700]),
                title: Text('Daftar Buku'),
                onTap: () => _onDrawerItemTapped(0),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.brown[700]),
                title: Text('Profil'),
                onTap: () => _onDrawerItemTapped(1),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent),
                title: Text('Keluar'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.id,
                    (route) => false,
                  );
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Logout berhasil")));
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(selectedIndex == 0 ? 'Daftar Buku' : 'Profil'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 143, 124, 117),
        foregroundColor: Colors.white,
        actions: selectedIndex == 0
            ? [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddBookPage(onBookAdded: _loadBooks),
                      ),
                    );
                  },
                ),
              ]
            : null,
      ),
      backgroundColor: const Color.fromARGB(255, 199, 196, 195),
      body: selectedIndex == 0 ? _buildBookListView() : const AboutUs(),
    );
  }
}
