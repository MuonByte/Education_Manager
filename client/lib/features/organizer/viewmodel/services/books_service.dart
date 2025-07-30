import 'package:client/features/organizer/data/model/books.dart';

import 'package:hive_ce/hive.dart';

late Box<Books> booksBox;

class BooksService {
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(BooksAdapter());
    }

    await Hive.openBox('myBox');
    booksBox = await Hive.openBox<Books>('booksData');
  }
}