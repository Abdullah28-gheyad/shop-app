class LoginModel
{
  bool status ;
  String message ;
  Data data ;

  LoginModel.FromJson(Map <String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data =json['data'] !=null ? Data.FromJson(json['data']):null;
  }
}
class Data
{
  int id ;
  String name ;
  String email ;
  String password ;
  String token ;
  String phone ;

  Data.FromJson(Map<String , dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    phone = json['phone'];
  }
}