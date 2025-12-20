import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cv_shift/repo/models/cv_data.dart';

class CvDataRepo {
  final _collection = FirebaseFirestore.instance.collection('cv_data');

  Future<void> addCvData(CvData cvData) async {
    try {
      await _collection.add(cvData.toJson());
    } on FirebaseException catch (e) {
      throw Exception('Failed to add CV data: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while adding CV data: $e');
    }
  }

  Stream<List<CvData>> getCvDataStream(String userId) {
    return _collection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CvData.fromJson(doc.data()).copyWith(id: doc.id))
              .toList(),
        )
        .handleError((error) {
          print(error.toString());
          throw Exception('Failed to get CV data');
        });
  }

  Query getCvDataQuery(String userId) {
    return _collection.where('userId', isEqualTo: userId);
  }

  Future<void> updateCvData(CvData cvData) async {
    try {
      await _collection.doc(cvData.id).update(cvData.toJson());
    } on FirebaseException catch (e) {
      throw Exception('Failed to update CV data: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while updating CV data: $e');
    }
  }

  Future<void> deleteCvData(String docId) async {
    try {
      await _collection.doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Failed to delete CV data: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while deleting CV data: $e');
    }
  }
}
