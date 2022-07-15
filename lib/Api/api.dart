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

  getProfile(String token) async {
    var res = await http.post(
      Uri.parse("$baseUrl/get-user-by-access_token"),
      body: {"access_token": token},
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getCategories() async {
    var res = await http.get(Uri.parse("$baseUrl/categories"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getFlashDeals(String token) async {
    var res = await http.get(Uri.parse("$baseUrl/flash-deals"),
        headers: {"Authorization": "Bearer $token"});

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

  updateProfile(String id, String name, String password, String token) async {
    var res = await http.post(Uri.parse("$baseUrl/profile/update"),
        body: {"id": id, "name": name, "password": password},
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  updateProfilePicture(String id, String token, String image) async {
    var res = await http.post(Uri.parse("$baseUrl/profile/update-image"),
        body: {"id": id, "filename": "profile.jpg", "image": image},
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getPurchaseHistory(String token) async {
    var res = await http.get(Uri.parse("$baseUrl/purchase-history"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getAddresses(String token) async {
    var res = await http.get(Uri.parse("$baseUrl/user/shipping/address"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  addUserAddress(
    String token,
    String id,
    String address,
    String countryId,
    String stateId,
    String cityId,
    String postal,
    String phone,
  ) async {
    var res =
        await http.post(Uri.parse("$baseUrl/user/shipping/create"), body: {
      "user_id": id,
      "address": address,
      "country_id": countryId,
      "city_id": cityId,
      "state_id": stateId,
      "postal_code": postal,
      "phone": phone
    }, headers: {
      "Authorization": "Bearer $token"
    });

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getCountries(String token) async {
    var res = await http.get(Uri.parse("$baseUrl/countries"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getCities(String token) async {
    var res = await http.get(Uri.parse("$baseUrl/cities"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  deleteUserAddress(String token, String id) async {
    var res = await http.get(Uri.parse("$baseUrl/user/shipping/delete/$id"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  updateUserAddressInCart(String token, String id, String addressId) async {
    var res = await http.post(Uri.parse("$baseUrl/update-address-in-cart"),
        body: {"user_id": id, "address_id": addressId},
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  deleteCartItem(String token, String id) async {
    var res = await http.delete(Uri.parse("$baseUrl/carts/$id"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  updateCartItem(String token, String cartIds, String cartQuantities) async {
    var res = await http.post(Uri.parse("$baseUrl/carts/process"),
        body: {"cart_ids": cartIds, "cart_quantities": cartQuantities},
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  getCartSummary(
    String token,
  ) async {
    var res = await http.get(Uri.parse("$baseUrl/cart-summary"),
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  applyCopoun(
      String id, String ownerId, String couponCode, String token) async {
    var res = await http.post(Uri.parse("$baseUrl/coupon-apply"),
        body: {"user_id": id, "owner_id": ownerId, "coupon_code": couponCode},
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  removeCopoun(String id, String ownerId, String token) async {
    var res = await http.post(Uri.parse("$baseUrl/coupon-remove"),
        body: {"user_id": id, "owner_id": ownerId},
        headers: {"Authorization": "Bearer $token"});

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }

  createOrder(String id, String ownerId, String token) async {
    var res = await http.post(Uri.parse("$baseUrl/order/store"), body: {
      "owner_id": ownerId,
      "user_id": id,
      "payment_type": "cash_payment"
    }, headers: {
      "Authorization": "Bearer $token"
    });

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return false;
    }
  }
}
