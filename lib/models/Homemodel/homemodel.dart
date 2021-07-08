class HomeModel
{
  bool status ;
  Data data ;
  HomeModel.FromJson(Map<String , dynamic> json)
  {
    status = json['status'] ;
    data =Data.FromJson(json['data'])  ;
  }
}
class Data
{
   List <banners> Banners = [] ;
   List <products> Products = [] ;
   Data.FromJson(Map<String , dynamic> json)
   {
     json['banners'].forEach ((element){
       Banners.add(banners.FromJson(element)) ;
     });
     json['products'].forEach ((element){
       Products.add(products.FromJson(element)) ;
     });
   }
}
class banners
{
  dynamic id   ;
  String image ;
  banners.FromJson(Map <String , dynamic>json)
  {
    id = json['id'] ;
    image = json['image'] ;
  }
}
class products
{
    int id ;
    dynamic price ;
    dynamic old_price ;
    dynamic discount ;
    String image ;
    String name ;
    bool in_favorite ;
    products.FromJson(Map<String , dynamic> json)
    {
      id = json['id'] ;
      price = json['price'] ;
      old_price = json['old_price'] ;
      discount = json['discount'] ;
      image = json['image'] ;
      name = json['name'] ;
      in_favorite = json['in_favorites'] ;
    }
}