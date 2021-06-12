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
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var dataController = TextEditingController();

  _addPost() async{
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String data = dataController.text.toString();
    if(firstname.isEmpty || lastname.isEmpty || content.isEmpty || data.isEmpty) return;
    _apiAddPost(data,content,firstname,lastname);
  }

  _apiAddPost(String firstname, String lastname, String data,String content) async{
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id,firstname,lastname,data,content)).then((response) => {
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
                controller: firstnameController,
                decoration: InputDecoration(
                  hintText: 'firstname',
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                  hintText: 'lastname',
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
              TextField(
                controller: dataController,
                decoration: InputDecoration(
                  hintText: 'data',
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
