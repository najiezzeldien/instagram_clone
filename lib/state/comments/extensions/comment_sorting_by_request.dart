import 'package:instagram_clone_course/enums/date_sorting.dart';
import 'package:instagram_clone_course/state/comments/models/comment.dart';
import 'package:instagram_clone_course/state/comments/models/post_comments_request.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sorteDocuments = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case DateSorting.newestOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.oldestOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sorteDocuments;
    } else {
      return this;
    }
  }
}
