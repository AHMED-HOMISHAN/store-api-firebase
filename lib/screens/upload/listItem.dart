import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/screens/upload/uploads.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class ListsItems_page extends StatefulWidget {
  const ListsItems_page({
    Key? key,
  }) : super(key: key);

  @override
  State<ListsItems_page> createState() => _ListsItems_pageState();
}

class _ListsItems_pageState extends State<ListsItems_page> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController messageEditingController = TextEditingController();
  TextEditingController urlEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notificatios_AppBar(context),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
        child: Column(
          children: [
            //firebase begin

            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Notifications')
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 15,
                            ),
                            height: 150,
                            child: InkWell(
                              onTap: () async {
                                if (await canLaunch(data['url'])) {
                                  await launch(data['url']);
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 15),
                                            blurRadius: 25,
                                            color: Colors.black12),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 20 / 3),
                                            child: Text(
                                              data['title'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              data['content'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                titleEditingController.text =
                                                    data['title'];
                                                messageEditingController.text =
                                                    data['content'];
                                                urlEditingController.text =
                                                    data['url'];
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Dialog(
                                                              child: Container(
                                                                color: Colors
                                                                    .white,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      ListView(
                                                                    shrinkWrap:
                                                                        true,
                                                                    children: <
                                                                        Widget>[
                                                                      Column(
                                                                        children: [
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          TextField(
                                                                            controller:
                                                                                titleEditingController,
                                                                            textInputAction:
                                                                                TextInputAction.newline,
                                                                            minLines:
                                                                                2,
                                                                            maxLines:
                                                                                100,
                                                                            onEditingComplete: () =>
                                                                                FocusScope.of(context).nextFocus(),
                                                                            decoration: InputDecoration(
                                                                                labelText: "عنوان الاشعار",
                                                                                counterText: "",
                                                                                hintText: "إدخل عنوان الاشعار",
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black)),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red))),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          TextField(
                                                                            controller:
                                                                                messageEditingController,
                                                                            textInputAction:
                                                                                TextInputAction.newline,
                                                                            minLines:
                                                                                5,
                                                                            maxLines:
                                                                                100,
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            onEditingComplete: () =>
                                                                                FocusScope.of(context).nextFocus(),
                                                                            decoration: InputDecoration(
                                                                                labelText: "محتوى الاشعار",
                                                                                counterText: "",
                                                                                hintText: "إدخل محتوى المشروع",
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black)),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red))),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          TextField(
                                                                            controller:
                                                                                urlEditingController,
                                                                            textInputAction:
                                                                                TextInputAction.newline,
                                                                            minLines:
                                                                                2,
                                                                            maxLines:
                                                                                100,
                                                                            onEditingComplete: () =>
                                                                                FocusScope.of(context).nextFocus(),
                                                                            decoration: InputDecoration(
                                                                                labelText: "رابط المشروع",
                                                                                counterText: "",
                                                                                hintText: "إدخل رابط المشروع",
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black)),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red))),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Center(
                                                                        child: TextButton(
                                                                            autofocus: true,
                                                                            style: ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                                                            ),
                                                                            child: const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text('تحديث البيانات ',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  )),
                                                                            ),
                                                                            onPressed: () {
                                                                              snapshot.data!.docs[i].reference.update({
                                                                                "content": messageEditingController.text,
                                                                                "title": titleEditingController.text,
                                                                                "url": urlEditingController.text,
                                                                              }).whenComplete(() => Navigator.pop(context));
                                                                            }),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Center(
                                                                        child: TextButton(
                                                                            autofocus: true,
                                                                            style: ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                                                            ),
                                                                            child: const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text('حذف الاشعار',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  )),
                                                                            ),
                                                                            onPressed: () {
                                                                              snapshot.data!.docs[i].reference.delete().whenComplete(() => Navigator.pop(context));
                                                                            }),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ));
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Text("NO Internat");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

AppBar notificatios_AppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const uploads()));
        },
      ),
      const Spacer(),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
