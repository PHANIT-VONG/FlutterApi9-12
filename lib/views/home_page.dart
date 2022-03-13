import 'package:flutter/material.dart';
import 'package:flutter_api/controllers/post_controller.dart';
import 'package:flutter_api/models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getPost();
  }

  List<PostModel>? postList = [];
  bool status = false;
  void getPost() async {
    postList = await PostController().getPost();
    if (postList != null) {
      setState(() => status = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: status,
        child: ListView.builder(
          itemCount: postList!.length,
          itemBuilder: (context, index) {
            var data = postList![index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(data.id!.toString()),
                ),
                title: Text(data.title!, maxLines: 1),
                subtitle: Text(data.body!, maxLines: 3),
                trailing: Text(data.userId!.toString()),
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
