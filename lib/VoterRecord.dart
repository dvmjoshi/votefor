import 'package:cloud_firestore/cloud_firestore.dart';
class VoterRecord{
final String name;
final String imageurl;
final int votes;
final DocumentReference reference;
final DocumentSnapshot  snapshot;


VoterRecord.fromMap(Map<String,dynamic>map,{this.reference,this.snapshot})
    :assert(map["name"]!=null),
      assert(map["votes"]!=null),
      assert(map["imageurl"]!=null),

name=map["name"],
imageurl=map["imageurl"],
votes=map["votes"];

VoterRecord.fromSnapshot(DocumentSnapshot snapshot)
  :this.fromMap(snapshot.data,reference:snapshot.reference);
@override
  String toString() =>"VoterRecord<$name:$votes:$imageurl>";
}