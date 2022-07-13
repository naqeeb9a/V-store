import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/Functionality/functionality.dart';

class Api {
  String baseUrl = "http://vstore.kissancorner.pk/api/v2";
  login(email, password) async {
    var res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      body: {"email": email, "password": password},
    );
    return res;
  }

  signUp(email, name, password) async {
    var res = await http.post(Uri.parse("$baseUrl/auth/signup"), body: {
      "email_or_phone": email,
      "register_by": "email",
      "name": name,
      "password": password
    });
    return res;
  }

  getCategories() async {
    var res = await http.get(Uri.parse("$baseUrl/categories"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getCategoriesProducts(id) async {
    var res = await http.get(Uri.parse(
        "$baseUrl/products/category/$id?page=${CustomCounter.incement}"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getProducts() async {
    var res = await http
        .get(Uri.parse("$baseUrl/products?page=${CustomCounter.incement}"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  checkIfInWishList(String productId, String userId, String token) async {
    var res = await http.get(
        Uri.parse(
            "$baseUrl/wishlists-check-product?product_id=$productId&user_id=$userId"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getBestSellingProducts() async {
    var res = await http.get(Uri.parse("$baseUrl/products/best-seller"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getBrands({int page = 1}) async {
    var res = await http.get(Uri.parse("$baseUrl/brands?page=$page"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getBrandProducts(
    String brandId,
  ) async {
    var res = await http.get(Uri.parse(
        "$baseUrl/products/brand/$brandId?page=${CustomCounter.incement}"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getUserWishList(String token) async {
    var res = await http.get(Uri.parse("$baseUrl/wishlists"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getUserCart(String token) async {
    var res = await http.post(Uri.parse("$baseUrl/carts"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  Future<http.Response> addProductToWishList(
      String productId, String userId, String token) async {
    var res = await http.get(
        Uri.parse(
            "$baseUrl/wishlists-add-product?product_id=$productId&user_id=$userId"),
        headers: {"Authorization": "Bearer $token"});

    return res;
  }

  Future<http.Response> removeProductToWishList(
      String productId, String userId, String token) async {
    var res = await http.get(
        Uri.parse(
            "$baseUrl/wishlists-remove-product?product_id=$productId&user_id=$userId"),
        headers: {"Authorization": "Bearer $token"});

    return res;
  }

  addToCart(
      String productId, String userId, String token, String variant) async {
    var res = await http.post(Uri.parse("$baseUrl/carts/add"), body: {
      "id": productId,
      "variant": variant,
      "user_id": userId,
      "quantity": "1",
    }, headers: {
      "Authorization": "Bearer $token"
    });

    return res;
  }

  searchProducts({String? text}) async {
    var res = await http.get(Uri.parse(
        "$baseUrl/products/search${text == null ? "" : "?name=$text"}"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  updateCart(String token, String productId, String productQty) async {
    var res = await http.post(Uri.parse("$baseUrl/carts/process"),
        body: {"cart_ids": productId, "cart_quantities": productQty},
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }
}
