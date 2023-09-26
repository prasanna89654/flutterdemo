import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterdemo/model.dart';
import 'package:http/http.dart';

class CartProvider {
  final String postsURL = "http://192.168.1.136:8080/";
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJjYzhhYzU3LWNiYTItNGEzZC04MDkxLWUyZjcyNzI4NmJlNiIsImlhdCI6MTY5NTA5OTAyOSwiZXhwIjoxNjk3NjkxMDI5fQ.4ho7dzK1Tw2YjKFVq557qeL-wqrYRMH4nkAiX9yyVes";
  Future<List<OrderModel>> getOrders() async {
    try {
      Response res =
          await get(Uri.parse("${postsURL}order/getAllOrders"), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      // print(res.statusCode);
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<OrderModel> posts = body
            .map(
              (dynamic item) => OrderModel.fromJson(item),
            )
            .toList();
        return posts;
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartModel>> getCarts() async {
    try {
      Response res =
          await get(Uri.parse("${postsURL}cart/getAllCart"), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      // print(res.statusCode);
      
        List<dynamic> body = jsonDecode(res.body);
        List<CartModel> posts = body
            .map(
              (dynamic item) => CartModel.fromJson(item),
            )
            .toList();
        return posts;
     
    } catch (e) {
      rethrow;
    }
  }

  Future<int> postOrder(var data) async {
    try {
      Response res = await post(Uri.parse("${postsURL}order/createOrder"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: json.encode(data));

      return res.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SearchModel>> searchBook(dynamic data) async {
    try {
      Response res = await get(
        Uri.parse("${postsURL}report/search?title=$data"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(res.body);
      return List<SearchModel>.from(
          json.decode(res.body).map((x) => SearchModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }
}

final cartRepoProvider = Provider<CartProvider>((ref) {
  return CartProvider();
});

final orderProvider = FutureProvider.autoDispose<List<OrderModel>>((ref) async {
  final repo = ref.watch(cartRepoProvider);
  return repo.getOrders();
});

final cartProvider = FutureProvider.autoDispose<List<CartModel>>((ref) async {
  final repo = ref.watch(cartRepoProvider);
  return repo.getCarts();
});

final searchProvider = FutureProvider.family
    .autoDispose<List<SearchModel>, dynamic>((ref, data) async {
  final repo = ref.watch(cartRepoProvider);
  return repo.searchBook(data);
});
