import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_app/core/services/database_service.dart';

class FirestoreService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await firestore.collection(path).doc(documentId).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
    } on FirebaseException catch (e) {
      log('FirebaseException in FirestoreService.addData: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Exception in FirestoreService.addData: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (documentId != null) {
        var data = await firestore.collection(path).doc(documentId).get();
        return data.data() as Map<String, dynamic>;
      } else {
        // 1. Start with the base collection reference
        Query firestoreQuery = firestore.collection(path);

        // 2. Apply Ordering if provided in the query map
        if (query != null && query.containsKey('orderBy')) {
          firestoreQuery = firestoreQuery.orderBy(
            query['orderBy'],
            descending: query['descending'] ?? false,
          );
        }

        // 3. Apply Limit if provided
        if (query != null && query.containsKey('limit')) {
          firestoreQuery = firestoreQuery.limit(query['limit'] as int);
        }

        if (query != null && query.containsKey('whereField')) {
          firestoreQuery = firestoreQuery.where(
            query['whereField'],
            isEqualTo: query['whereValue'],
          );
        }
        // 4. Execute the built query
        var data = await firestoreQuery.get();
        return data.docs.map((e) => e.data() as Map<String, dynamic>).toList();
      }
    } on FirebaseException catch (e) {
      log('FirebaseException in FirestoreService.getData: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Exception in FirestoreService.getData: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<bool> isDataExists({
    required String path,
    required String documentId,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.exists;
  }
}
