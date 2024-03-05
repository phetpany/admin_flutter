import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference buss = 
  FirebaseFirestore.instance.collection('BusType');

  Future<void> addBus(String name) {
    return buss.add({
      'name': name,
      'Timestamp': Timestamp.now(), 
    });
  }

  Stream<QuerySnapshot> getBusStream() {
    // ปรับให้เรียงลำดับตาม Timestamp หรือ name ตามที่คุณต้องการ
    final busStream= buss.orderBy('Timestamp', 
    descending: true).snapshots(); 
    
    
   return busStream;
  }
 Future<void> updateBus(String docID,String newBus){
  return buss.doc(docID).update({
      'name':newBus,
      'Timestamp':Timestamp.now(),
  });

 }
 Future<void> deleteBus(String docID){
  return buss.doc(docID).delete();

 }

}
