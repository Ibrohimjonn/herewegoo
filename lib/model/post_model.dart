class Post{
  String userId;
  String firstname;
  String lastname;
  String data;
  String content;

  Post(String userId,String firstname,String lastname, String title,String content){
    this.userId = userId;
    // ignore: unnecessary_statements
    this.firstname;
    // ignore: unnecessary_statements
    this.lastname;
    this.data = title;
    this.content = content;
  }
  Post.fromJson(Map<String,dynamic>json)
  : userId = json['userId'],
  firstname = json['firstname'],
  lastname = json['lastname'],
  data = json['data'],
  content = json['content'];

  Map<String,dynamic> toJson() => {
    'userId': userId,
    'firstname': firstname,
    'lastname': lastname,
    'data': data,
    'content': content,
  };
}