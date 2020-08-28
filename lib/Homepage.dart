import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:votefor/VoterRecord.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
final dummydata=[
{"name":"Divyam","votes":20,"imageurl":"https://cdn.dribbble.com/users/3281732/screenshots/7421960/media/9dd2e5490681a75e42c7f2c39bfeb905.jpeg"},
{"name":"pusp","votes":18,"imageurl":"https://cdn.dribbble.com/users/3281732/screenshots/7421960/media/9dd2e5490681a75e42c7f2c39bfeb905.jpeg"},
  {"name":"Pawan","votes":19,"imageurl":"https://cdn.dribbble.com/users/3281732/screenshots/7421960/media/9dd2e5490681a75e42c7f2c39bfeb905.jpeg"},
  {"name":"Mac","votes":17,"imageurl":"https://cdn.dribbble.com/users/3281732/screenshots/7421960/media/9dd2e5490681a75e42c7f2c39bfeb905.jpeg"}
];
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vote for"),
        leading: InkWell(
          onTap: (){
           // voterrecord.reference.updateData({"votes":voterrecord.votes-voterrecord.votes});
          },
          child: Icon(Icons.refresh),
        ),
      ),
      body: _showdata(context),
    );
  }
  Widget _showdata(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("votefor").snapshots(),
      builder: (context,snapshot) {
        if(!snapshot.hasData)return LinearProgressIndicator();
        return _builtList(context, snapshot.data.documents);
      }
    );
  }
  Widget _builtList(BuildContext context,List<DocumentSnapshot> snapshot){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children:snapshot.map((data) => _showCanddateList(context, data)).toList(),
      ),
    );

  }
  Widget _showCanddateList(BuildContext context, DocumentSnapshot data){{
    final voterrecord=VoterRecord.fromSnapshot(data);
    return Padding(
        key:ValueKey(voterrecord.name),
        padding: EdgeInsets.all(8),
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
      ),
child: GestureDetector(
  onTap: (){
   setState(() {
     voterrecord.reference.updateData({"votes":FieldValue.increment(1)});
     if(voterrecord.votes >=20){
      voterrecord.reference.updateData({"votes":voterrecord.votes-voterrecord.votes});
       return Alert(
           context: context,
           image:Image.network(voterrecord.imageurl),
           title: "You are the  winner ",
           desc: voterrecord.name)
           .show();}
   });
   print("you win ${voterrecord.name}");
   },
  child:   Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(voterrecord.imageurl),
        Text(voterrecord.name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),),
        Text(voterrecord.votes.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400)),

      ],
    ),
  ),
),
//      child: ListTile(
//       leading:Image.network(voterrecord.imageurl),
//        title: Text(voterrecord.name),
//        trailing: Text(voterrecord.votes.toString()),
//        onTap:()=> voterrecord.reference.updateData({"votes":FieldValue.increment(1)}),
//
//      ),
    ),);
  }
}}
