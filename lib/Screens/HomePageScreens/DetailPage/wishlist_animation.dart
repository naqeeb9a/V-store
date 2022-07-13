import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:store/Api/api.dart';

class AddToWishList extends StatefulWidget {
  final String productId, userId, token;
  final bool isInWishList;

  const AddToWishList(
      {Key? key,
      required this.productId,
      required this.userId,
      required this.token,
      required this.isInWishList})
      : super(key: key);

  @override
  State<AddToWishList> createState() => _AddToWishListState();
}

class _AddToWishListState extends State<AddToWishList>
    with SingleTickerProviderStateMixin {
  bool isFav = false;
  late final AnimationController _controller;
  @override
  void initState() {
    isFav = widget.isInWishList;
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    if (widget.isInWishList == true) {
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          if (isFav == false) {
            isFav = true;
            Response res = await Api().addProductToWishList(
                widget.productId, widget.userId, widget.token);
            if (res.statusCode == 200) {
              _controller.forward();
              Fluttertoast.showToast(msg: "Added to Wishlist");
            } else {
              Fluttertoast.showToast(msg: "Unable to add in Wishlist");
            }
          } else {
            isFav = false;
            Response res = await Api().removeProductToWishList(
                widget.productId, widget.userId, widget.token);
            if (res.statusCode == 200) {
              _controller.reverse();
              Fluttertoast.showToast(msg: "Removed from Wishlist");
            } else {
              Fluttertoast.showToast(msg: "Unable to add in Wishlist");
            }
          }
        },
        child: LottieBuilder.asset(
          "assets/wishlist.json",
          width: 50,
          controller: _controller,
        ));
  }
}
