class User{
  String? name;
  String? email;
  String? id;


  User({required this.name,required this.email,required this.id});

  User.fromFireStore(Map<String, dynamic> data){
    id = data["id"];
    email =data["email"];
    name = data["name"];
  }

  Map<String,dynamic> toFireStore(){
    return{
      "id":id,
      "name":name,
      "email":email
    };
  }


}


