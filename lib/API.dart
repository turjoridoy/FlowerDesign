import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:wadaaro/Model.dart';

import 'constant.dart';

Future<List<ProductListModel>> getAllFlowers() async {
  var client = new http.Client();
  try {
    var response = await client.get('$baseURL/flower/api/flowers/');
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      print(jsonResponse
          .map<ProductListModel>((obj) => ProductListModel.fromJson(obj))
          .toList());
      return jsonResponse
          .map<ProductListModel>((obj) => ProductListModel.fromJson(obj))
          .toList();
    } else {
      return [];
    }
  } finally {
    client.close();
  }
}

Future<List<ProductListModel>> getFlowerFromCategory(id) async {
  var client = new http.Client();
  try {
    var response =
        await client.get('$baseURL/flower/categories/flowers?id=${id}');
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      print(jsonResponse
          .map<ProductListModel>((obj) => ProductListModel.fromJson(obj))
          .toList());
      return jsonResponse
          .map<ProductListModel>((obj) => ProductListModel.fromJson(obj))
          .toList();
    } else {
      return [];
    }
  } finally {
    client.close();
  }
}

Future<List<CategoryModel>> getCategories() async {
  var client = new http.Client();
  try {
    var response = await client.get('$baseURL/flower/api/categories/');
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      return jsonResponse
          .map<CategoryModel>((obj) => CategoryModel.fromJson(obj))
          .toList();
    } else {
      return [];
    }
  } finally {
    client.close();
  }
}

Future<List<Slider>> getSliders() async {
  var client = new http.Client();
  try {
    var response = await client.get('$baseURL/flower/api/slider/');
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      return jsonResponse.map<Slider>((obj) => Slider.fromJson(obj)).toList();
    } else {
      return [];
    }
  } finally {
    client.close();
  }
}

Future<http.Response> makePayment(no, mm, yy, cvc, amount) async {
  var client = new http.Client();
  var response = await client.get(
      '$baseURL/flower/pay/?no=${no}&amount=${amount}&mm=${mm}&yy=${yy}&cvc=${cvc}');
  client.close();
  return response;
}
