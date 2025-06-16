import 'package:flutter/material.dart';
import 'package:manajemen_buku_pribadi/model/book_model.dart';

class BookDetailPage extends StatelessWidget {
  final BookModel book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail buku'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 78, 61, 55),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 216, 197, 190),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: const Color.fromARGB(255, 226, 220, 217),
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.book, size: 64, color: Colors.blue),
                      SizedBox(height: 12),
                      Text(
                        'buku',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                book.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                book.author,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                }),
              ),
              SizedBox(height: 16),
              Text(
                book.genre,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 234, 232),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown,
                      blurRadius: 8,
                      offset: Offset(5, 10),
                    ),
                  ],
                  border: Border.all(
                    color: const Color.fromARGB(255, 124, 114, 114),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    book.description,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
