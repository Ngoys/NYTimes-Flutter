import 'package:equatable/equatable.dart';

class ArticleDataModel extends Equatable {
  const ArticleDataModel({
    required this.id,
    this.title,
    this.publishedDate,
  });

  final String id;
  final String? title;
  final DateTime? publishedDate;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        publishedDate,
      ];
}
