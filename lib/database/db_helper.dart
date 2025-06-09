import 'package:manajemen_buku_pribadi/model/book_model.dart';
import 'package:manajemen_buku_pribadi/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // Initialize the database
  static Future<Database> initDB() async {
    final dbpath = await getDatabasesPath();
    return openDatabase(
      join(dbpath, 'manajemen_buku_pribadi.db'),
      version: 1,
      onCreate: (db, version) async {
        // Creating the 'users' table with correct AUTOINCREMENT syntax
        await db.execute('''
          CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT, 
          username TEXT, 
          email TEXT, 
          phone TEXT, 
          password TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE books(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          author TEXT,
          description TEXT,
          genre TEXT
          )
        ''');
      },
    );
  }

  // Register a new user
  static Future<void> registerUser({UserModel? data}) async {
    final db = await initDB();

    // Insert data into the correct table ('users')
    await db.insert(
      'users', // Table name should match 'users' (plural)
      {
        'name': data?.name,
        'username': data?.username,
        'email': data?.email,
        'phone': data?.phone,
        'password': data?.password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("User registered successfully");
  }

  // Login method to authenticate the user
  static Future<UserModel?> login(String email, String password) async {
    final db = await initDB();
    final List<Map<String, dynamic>> data = await db.query(
      "users", // Correct table name
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (data.isNotEmpty) {
      return UserModel.fromMap(
        data.first,
      ); // Assuming UserModel has a fromMap() method
    } else {
      return null;
    }
  }

  // Add a new book to the database
  static Future<void> addBook({required BookModel book}) async {
    final db = await initDB();

    await db.insert(
      'books', // Table name
      book.toMap(), // Convert BookModel to map
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Book added successfully");
  }

  // Get all books from the database
  static Future<List<BookModel>> getBooks() async {
    final db = await initDB();
    final List<Map<String, dynamic>> data = await db.query('books');

    return List.generate(data.length, (i) {
      return BookModel.fromMap(data[i]);
    });
  }

  // Get a specific book by ID
  static Future<BookModel?> getBookDetails(int id) async {
    final db = await initDB();
    final List<Map<String, dynamic>> data = await db.query(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (data.isNotEmpty) {
      return BookModel.fromMap(data.first);
    } else {
      return null;
    }
  }

  // Edit an existing book
  static Future<void> editBook({required BookModel book}) async {
    final db = await initDB();

    await db.update(
      'books',
      book.toMap(), // Convert BookModel to map
      where: 'id = ?',
      whereArgs: [book.id],
    );
    print("Book updated successfully");
  }

  // Delete Book
  // In DbHelper class
  static Future<void> deleteBook(int bookId) async {
    final db = await initDB();
    await db.delete('books', where: 'id = ?', whereArgs: [bookId]);
    print("Book deleted successfully");
  }
}
