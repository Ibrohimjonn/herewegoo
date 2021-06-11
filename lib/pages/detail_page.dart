import 'package:flutter/material.dart';
import 'package:herewegoo/model/post_model.dart';
import 'package:herewegoo/services/prefs_service.dart';
import 'package:herewegoo/services/rtdb_service.dart';

class Detail extends StatefulWidget {

  static final String id = 'detail';

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async{
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if(title.isEmpty || content.isEmpty) return;
    _apiAddPost(title,content);
  }

  _apiAddPost(String title,String content) async{
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id,title,content)).then((response) => {
      _respAddPost(),
    });
  }

  _respAddPost(){
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Add Post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 15,),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'title',
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'content',
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  onPressed: _addPost,
                  color: Colors.deepOrange,
                  child: Text('Add',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
