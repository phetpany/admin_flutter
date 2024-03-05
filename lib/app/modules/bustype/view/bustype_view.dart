// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_admin/provider/statecrud.dart';
import 'package:provider/provider.dart';

class BustypeView extends StatefulWidget {
  BustypeView({Key? key}) : super(key: key);

  @override
  _BustypeViewState createState() => _BustypeViewState();
}

class _BustypeViewState extends State<BustypeView> {
  final FirestoreService firestoreservice = FirestoreService();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ຈັດການຂໍ້ມູນປະເພດລົດ',
          style: GoogleFonts.notoSansLao(
            fontSize: 20,
            color: Colors.redAccent,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              width: double.infinity,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ຄົ້ນຫາ..',
                  hintStyle: GoogleFonts.notoSansLao(),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ເພີ່ມ',
                          style: GoogleFonts.notoSansLao(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.add,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ລາຍງານ',
                          style: GoogleFonts.notoSansLao(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.read_more_sharp,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestoreservice.getBusStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> busList = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: busList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = busList[index];
                        String docID = document.id;
                        String busText = document['name'];

                        return Card(
                          child: ListTile(
                            title: Text(busText,
                            style: GoogleFonts.notoSansLao(fontSize: 17)),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () => openDialog(docID: docID),
                                    leading: Icon(
                                      Icons.edit,
                                      color: Colors.orangeAccent,
                                    ),
                                    title: Text(
                                      'ແກ້ໄຂ',
                                      style: GoogleFonts.notoSansLao(),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () => firestoreservice.deleteBus(docID),
                                    leading: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                    title: Text(
                                      'ລົບ',
                                      style: GoogleFonts.notoSansLao(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Text("No data");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog({String? docID}) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'ຂໍ້ມູນປະເພດລົດ',
            style: GoogleFonts.notoSansLao(
              fontSize: 15,
              color: Colors.black26,
            ),
          ),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'ປ້ອນຂໍ້ມູນປະເພດລົດ',
              hintStyle: GoogleFonts.notoSansLao(),
              prefixIcon: IconButton(
                icon: Icon(Icons.car_crash),
                onPressed: () {},
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
               if(docID == null){
                 firestoreservice.addBus(textController.text);
               }

               else{
                firestoreservice.updateBus(docID, textController.text);
               }

                textController.clear();

                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue), 
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ບັນທືກ',
                    style: GoogleFonts.notoSansLao(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10, 
                  ),
                  const Icon(
                    Icons.save,
                    size: 24.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
