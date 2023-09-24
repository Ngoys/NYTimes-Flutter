import 'package:equatable/equatable.dart';

class DocumentArticleDataModel extends Equatable {
  const DocumentArticleDataModel({
    required this.id,
    this.abstractText,
    this.publishedDate,
  });

  final String id;
  final String? abstractText;
  final DateTime? publishedDate;

  @override
  List<Object?> get props => <Object?>[
        id,
        abstractText,
        publishedDate,
      ];
}
