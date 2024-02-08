import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application1/core/firebase_cloud_store_util.dart';
import 'package:flutter_application1/models/category_model.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController photoUrlController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController itemCountController = TextEditingController();
  final _addCategoryFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new category"),
      ),
      body: Form(
        key: _addCategoryFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Invalid name";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: itemCountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "item Count",
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Invalid number";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: descController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Invalid Description";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: photoUrlController,
                  decoration: const InputDecoration(
                    labelText: "Image Url",
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Invalid URL";
                    }
                  },
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        if (_addCategoryFormKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          var data = CategoryModel(
                            name: nameController.text,
                            desc: descController.text,
                            image: photoUrlController.text,
                            itemNo: itemCountController.text,
                          );
                          bool result =
                              await FirebaseCloudStoreUtil.addNewCategory(data);
                          if (result) {
                            nameController.clear();
                            descController.clear();
                            photoUrlController.clear();
                            itemCountController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Category is Added :D"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Something went wrong!!"),
                              ),
                            );
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                      child: const Text("Add Category"),
                    ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('your_collection_name')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['full_name']),
                        subtitle: Text(data['company']),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
