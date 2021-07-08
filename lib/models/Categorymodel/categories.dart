import 'package:finalecommerce/shared/components/Constants.dart';

class CategoryModel {
  CategoryData data;

  CategoryModel({ this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CategoryData.fromJson(json['data']) : null;
  }

}

class CategoryData {
  List<DataCategory> data=[];
  CategoryData(
      {
        this.data,});
  CategoryData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new DataCategory.fromJson(v));

      });
    }
  }

}

class DataCategory {
  int id;
  String name;
  String image;
  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}
