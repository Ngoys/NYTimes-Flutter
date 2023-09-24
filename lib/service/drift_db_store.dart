import 'package:injectable/injectable.dart';
import 'package:nytimes/service/drift_db/drift_db.dart';

@lazySingleton
class DriftDBStore {
  DriftDBStore({
    required this.db,
  });

  final DriftDB db;

  // Future<InspectionDataModel> createOrUpdateInspection(
  //         InspectionDataModel model) async =>
  //     db.articleDao.createOrUpdate(model);
}
