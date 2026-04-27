import 'package:flutter/material.dart';

import '../Data/models/report_model.dart';
import '../Data/repositories/report_repository.dart';

class ReportProvider with ChangeNotifier {
  final ReportRepository _repo = ReportRepository();

  Stream<List<ReportModel>> getUserReports(String userId) {
    return _repo.getUserReports(userId);
  }
}