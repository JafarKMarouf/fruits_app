abstract class DatabaseService {
  Future<String> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  });

  Future<bool> isDataExists({required String path, required String documentId});
}
