import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Home Page',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Text.rich(TextSpan(
                  text: "Title",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  children: const [
                    TextSpan(
                        text: " *",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ))
                  ])),
              const SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter Notification Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text.rich(TextSpan(
                  text: "Description",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  children: const [
                    TextSpan(
                        text: " *",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ))
                  ])),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter Notification Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text("Token",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tokenController,
                decoration: const InputDecoration(
                  hintText: 'Enter Token',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_descriptionController.text.isEmpty ||
                      _titleController.text.isEmpty) {
                    Get.showSnackbar(const GetSnackBar(
                        message: "Please enter title and description"));
                  }
                  // CustomNoti().showNotification(
                  //   title: _titleController.text,
                  //   description: _descriptionController.text,
                  // );
                },
                child: const Text('Send Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
