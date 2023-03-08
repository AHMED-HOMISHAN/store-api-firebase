import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class uploads extends StatefulWidget {
  const uploads({Key? key}) : super(key: key);

  @override
  uploadsState createState() => uploadsState();
}

class uploadsState extends State<uploads> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController messageEditingController = TextEditingController();
  TextEditingController urlEditingController = TextEditingController();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    late Map<String, dynamic> projects;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Notifications");

    data() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          });
      try {
        projects = {
          "title": titleEditingController.text,
          "content": messageEditingController.text,
          "url": urlEditingController.text,
        };

        collectionReference.add(projects).whenComplete(() {
          Navigator.pop(context);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            content: Text("حدث خطا ما")));
      }
    }

    void validateText() {
      FocusScope.of(context).unfocus();

      if (titleEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            content: Text(" تحذير العنوان فارغ")));
        return;
      }

      if (messageEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            content: Text(" تحذير الوصف فرغ ")));
        return;
      }
      if (urlEditingController.text.isEmpty) {
        urlEditingController.text = "...";
      }

      data();
    }

    AppBar _uploadAppBar(BuildContext context) {
      return AppBar(
        backgroundColor: Colors.red,
        title: const Text('الاشعارات'),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _uploadAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: titleEditingController,
                    textInputAction: TextInputAction.newline,
                    minLines: 2,
                    maxLines: 100,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                        labelText: "عنوان",
                        counterText: "",
                        hintText: "إدخل العنوان ",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: messageEditingController,
                    textInputAction: TextInputAction.newline,
                    minLines: 5,
                    maxLines: 100,
                    textAlign: TextAlign.start,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                        labelText: "وصف",
                        counterText: "",
                        hintText: "وصف",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: urlEditingController,
                    textInputAction: TextInputAction.newline,
                    minLines: 2,
                    maxLines: 100,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                        labelText: "رابط",
                        counterText: "",
                        hintText: "رابط الموقع ان وجد",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      validateText();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "ارسال الاشعار",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
