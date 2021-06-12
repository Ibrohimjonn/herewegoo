import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:herewegoo/model/post_model.dart';
import 'package:herewegoo/services/auth_service.dart';
import 'package:herewegoo/services/prefs_service.dart';
import 'package:herewegoo/services/rtdb_service.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {

  static final String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> items = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPost();
  }

  Future _openDetail() async{
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context){
        return new Detail();
      }
    ));
    if(results != null && results.containsKey("data")){
      print(results['data']);
      _apiGetPost();
    }
  }

  _apiGetPost() async{
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id).then((posts) => {
      _respPosts(posts),
    });
  }

  _respPosts(List<Post> posts) {
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
            onPressed: (){
              AuthService.signOutUser(context);
            },
          ),
        ],
        title: Text('All Posts',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx,i) {
          return itemOfList(items[i]);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        child: Icon(Icons.add),
      backgroundColor: Colors.deepOrange,
      ),
    );
  }
  Widget itemOfList(Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.userId,style: TextStyle(color: Colors.black),),
          Row(
            children: [
              SizedBox(height: 10,),
              Text(post.firstname,style: TextStyle(color: Colors.black,fontSize: 18),),
              SizedBox(width: 5,),
              Text(post.lastname,style: TextStyle(color: Colors.black,fontSize: 18),),
            ],
          ),
          SizedBox(height: 10,),
          Text(post.data,style: TextStyle(color: Colors.black,fontSize: 12),),
          SizedBox(height: 10,),
          Text(post.content,style: TextStyle(color: Colors.black,fontSize: 15),),
        ],
      ),
    );
  }

}
