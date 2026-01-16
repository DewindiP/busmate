import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  // ---------------- DATABASE INIT ----------------
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bus_booking.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // USERS TABLE
    await db.execute('''
      CREATE TABLE users(
        username TEXT PRIMARY KEY,
        password TEXT,
        role TEXT
      )
    ''');

    // BOOKINGS TABLE
    await db.execute('''
      CREATE TABLE bookings(
        id TEXT PRIMARY KEY,
        route TEXT,
        date TEXT,
        bus TEXT,
        seat INTEGER,
        passengerName TEXT,
        phone TEXT
      )
    ''');

    // SEATS TABLE
    await db.execute('''
      CREATE TABLE seats(
        route TEXT,
        date TEXT,
        seat INTEGER,
        bus TEXT,
        PRIMARY KEY (route, date, seat, bus)
      )
    ''');

    // Insert default admin when DB is first created
    await db.insert('users', {
      'username': 'admin',
      'password': 'admin123',
      'role': 'admin',
    });
  }

  // ---------------- ENSURE ADMIN ----------------
  static Future<void> ensureAdminExists() async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: ['admin'],
    );

    if (result.isEmpty) {
      await db.insert('users', {
        'username': 'admin',
        'password': 'admin123',
        'role': 'admin',
      });
    }
  }

  // ---------------- AUTH ----------------
  static Future<bool> validateAdmin(
      String username, String password) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'username = ? AND password = ? AND role = ?',
      whereArgs: [username, password, 'admin'],
    );

    return result.isNotEmpty;
  }

  // ---------------- SEAT ----------------
  static Future<bool> isSeatBooked(
      String route, String date, int seat, String bus) async {
    final db = await database;

    final result = await db.query(
      'seats',
      where: 'route = ? AND date = ? AND seat = ? AND bus = ?',
      whereArgs: [route, date, seat, bus],
    );

    return result.isNotEmpty;
  }

  static Future<void> bookSeat(
      String route, String date, int seat, String bus) async {
    final db = await database;

    await db.insert('seats', {
      'route': route,
      'date': date,
      'seat': seat,
       'bus': bus,
    });
  }

  // ---------------- BOOKINGS ----------------
  static Future<void> saveBooking(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('bookings', data);
  }

  static Future<List<Map<String, dynamic>>> getAllBookings() async {
    final db = await database;
    return await db.query('bookings');
  }
}
