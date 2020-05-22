import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderModel {
  int id;
  String name;
  String phone;
  String deliveryTime;
  String address;
  String noteForAdmin;
  bool isCancalled;
  bool isDelivered;
  bool isInProcess;
  String date;
  User user;
  String deliveryType;
  Product product;

  OrderModel(
      {this.id,
        this.name,
        this.phone,
        this.user,
        this.deliveryTime,
        this.address,
        this.noteForAdmin,
        this.isCancalled,
        this.isDelivered,
        this.isInProcess,
        this.date,
        this.deliveryType,
        this.product});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    user =
    json['user'] != null ? new User.fromJson(json['user']) : null;
    phone = json['phone'];
    deliveryTime = json['delivery_time'];
    address = json['address'];
    noteForAdmin = json['note_for_admin'];
    isCancalled = json['is_cancalled'];
    isDelivered = json['is_delivered'];
    isInProcess = json['is_in_process'];
    date = json['date'];
    deliveryType = json['delivery_type'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user'] = this.user;
    data['phone'] = this.phone;
    data['delivery_time'] = this.deliveryTime;
    data['address'] = this.address;
    data['note_for_admin'] = this.noteForAdmin;
    data['is_cancalled'] = this.isCancalled;
    data['is_delivered'] = this.isDelivered;
    data['is_in_process'] = this.isInProcess;
    data['date'] = this.date;
    data['delivery_type'] = this.deliveryType;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }

  static List<OrderModel> fromJsonList(jsonList) {
    return jsonList.map<OrderModel>((obj) => OrderModel.fromJson(obj)).toList();
  }
}

class Product {
  int id;
  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  String image;
  double price;
  double height;
  double width;
  String color;
  String colorAr;
  String createdAt;
  int category;

  Product(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.descriptionEn,
        this.descriptionAr,
        this.image,
        this.price,
        this.height,
        this.width,
        this.color,
        this.colorAr,
        this.createdAt,
        this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    image = json['image'];
    price = json['price'];
    height = json['height'];
    width = json['width'];
    color = json['color'];
    colorAr = json['color_ar'];
    createdAt = json['created_at'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['image'] = this.image;
    data['price'] = this.price;
    data['height'] = this.height;
    data['width'] = this.width;
    data['color'] = this.color;
    data['color_ar'] = this.colorAr;
    data['created_at'] = this.createdAt;
    data['category'] = this.category;
    return data;
  }
}


class ProductListModel {
  final int id;
  final String name_en;
  final String name_ar;
  final String description_en;
  final String description_ar;
  final String image;
  final double price;
  final double height;
  final double width;
  final String color;
  final String color_ar;
  final String created_at;
  final int category;

  ProductListModel({
    @required this.id,
    @required this.name_en,
    @required this.name_ar,
    @required this.description_en,
    @required this.description_ar,
    @required this.image,
    @required this.price,
    @required this.height,
    @required this.width,
    @required this.color,
    @required this.color_ar,
    @required this.created_at,
    @required this.category,
  });

  ProductListModel.fromJson(Map json)
      : id = json['id'],
        name_en = json['name_en'],
        name_ar = json['name_ar'],
        description_en = json['description_en'],
        description_ar = json['description_ar'],
        image = json['image'],
        price = json['price'],
        height = json['height'],
        width = json['width'],
        color = json['color'],
        color_ar = json['color_ar'],
        created_at = json['created_at'],
        category = json['category'];
}
class CategoryModel {
  int id;
  String name;
  String nameAr;
  String hashTag;
  String description;
  String descriptionAr;
  String image;

  CategoryModel(
      {this.id,
      this.name,
      this.nameAr,
      this.hashTag,
      this.description,
      this.descriptionAr,
      this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    hashTag = json['hash_tag'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['hash_tag'] = this.hashTag;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['image'] = this.image;
    return data;
  }
}
class User {
  int id;
  String lastLogin;
  String name;
  String email;
  String phone;
  bool isActive;
  bool isSuperuser;
  String password;
  String fireToken;
  String dateJoined;

  User(
      {this.id,
      this.lastLogin,
      this.name,
      this.email,
      this.phone,
      this.isActive,
      this.isSuperuser,
      this.password,
      this.fireToken,
      this.dateJoined});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastLogin = json['last_login'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isActive = json['is_active'];
    isSuperuser = json['is_superuser'];
    password = json['password'];
    fireToken = json['fire_token'];
    dateJoined = json['date_joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['last_login'] = this.lastLogin;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['is_active'] = this.isActive;
    data['is_superuser'] = this.isSuperuser;
    data['password'] = this.password;
    data['fire_token'] = this.fireToken;
    data['date_joined'] = this.dateJoined;
    return data;
  }

  static List<User> fromJsonList(jsonList) {
    return jsonList.map<User>((obj) => User.fromJson(obj)).toList();
  }
}
saveUser(String u) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'user_value';
  prefs.setString(key, u);
  print('saved $u');
}
Future<User> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString('user_value');

  if (value != null) {
    return User.fromJsonList(convert.jsonDecode(value))[0];
  } else {
    return null;
  }
}
saveLang(bool u) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'lang';
  prefs.setBool(key, u);
  print('saved $u');
}
Future<bool> getLang() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getBool('lang');
  if (value != null) {
    return value;
  } else {
    return true;
  }
}


class Information {
  int id;
  String aboutUs;
  String aboutUsAr;
  String address;
  String addressAr;
  String workingHour;
  String workingHourAr;
  String phoneAr;
  String phone;

  Information(
      {this.id,
        this.aboutUs,
        this.aboutUsAr,
        this.address,
        this.addressAr,
        this.workingHour,
        this.workingHourAr,
        this.phoneAr,
        this.phone});

  Information.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutUs = json['about_us'];
    aboutUsAr = json['about_us_ar'];
    address = json['address'];
    addressAr = json['address_ar'];
    workingHour = json['working_hour'];
    workingHourAr = json['working_hour_ar'];
    phoneAr = json['phone_ar'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about_us'] = this.aboutUs;
    data['about_us_ar'] = this.aboutUsAr;
    data['address'] = this.address;
    data['address_ar'] = this.addressAr;
    data['working_hour'] = this.workingHour;
    data['working_hour_ar'] = this.workingHourAr;
    data['phone_ar'] = this.phoneAr;
    data['phone'] = this.phone;
    return data;
  }


  static List<Information> fromJsonList(jsonList) {
    return jsonList.map<Information>((obj) => Information.fromJson(obj)).toList();
  }
}


class Slider {
  int id;
  String image;
  String createdAt;

  Slider({this.id, this.image, this.createdAt});

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
  }
  static List<Slider> fromJsonList(jsonList) {
    return jsonList.map<Slider>((obj) => Slider.fromJson(obj)).toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}