import 'package:client/features/organizer/data/model/books.dart';
import 'package:client/features/organizer/viewmodel/services/books_service.dart';

class BookTrackerViewModel {
  void addBook({
    required String name,
    required String subject,
    required String status,
    String? pdfPath,
  }) {
    if (name.trim().isEmpty || subject.trim().isEmpty || status.trim().isEmpty) return;

    booksBox.put(
      'BookKey_$name',
      Books(
        name: name, 
        subject: subject, 
        status: status,
        pdfPath: pdfPath
      ),
    );
  }

  void deleteBook(int index) {
    booksBox.deleteAt(index);
  }

  void updateBookStatus(int index, String newStatus) {
    final Books? book = booksBox.getAt(index);

    if (book != null) {
      final updatedBook = Books(
        name: book.name,
        subject: book.subject,
        status: newStatus,
      );

    booksBox.putAt(index, updatedBook);
  }
}

void updateBook({
  required int index,
  required String newStatus,
  String? newPdfPath,
}) {
  final oldBook = booksBox.getAt(index);
  if (oldBook == null) return;

  final updatedBook = Books(
    name: oldBook.name,
    subject: oldBook.subject,
    status: newStatus,
    pdfPath: newPdfPath ?? oldBook.pdfPath,
  );

  booksBox.putAt(index, updatedBook);
}

}
