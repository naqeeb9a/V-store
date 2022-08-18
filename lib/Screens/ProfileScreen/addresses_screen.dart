import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/Screens/Cart/add_addresses.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

import '../../Functionality/functionality.dart';
import '../../provider/user_data_provider.dart';

class AddressesScreen extends StatefulWidget {
  final bool showConfirmButton;
  final dynamic function;
  const AddressesScreen(
      {Key? key, this.showConfirmButton = false, this.function})
      : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int indexValue = 0;
  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
      appBar: BaseAppBar(
        title: "Addresses",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: CustomButton(
            text: widget.showConfirmButton ? "Select Address" : "Add Address",
            function: () async {
              if (widget.showConfirmButton) {
                if (indexValue == 0) {
                  Fluttertoast.showToast(msg: "Select an address first");
                } else {
                  EssentialFunctions.loader(context);
                  var res = await Api().updateUserAddressInCart(
                      user!.token.toString(),
                      user.id.toString(),
                      indexValue.toString());
                  if (res != false) {
                    Navigator.of(context, rootNavigator: true).pop();
                    if (widget.showConfirmButton) {
                      Navigator.pop(context, widget.function());
                    } else {
                      KRoutes().pop(context);
                    }
                    Fluttertoast.showToast(msg: "Address Selected");
                  } else {
                    Navigator.of(context, rootNavigator: true);
                    Fluttertoast.showToast(msg: "Something went wrong");
                  }
                }
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAddress(
                              function: () {
                                setState(() {});
                              },
                            ))).then((value) {
                  _controller.reset();
                  _controller.forward();
                });
              }
            },
            color: kDarkPurple),
      ),
      body: FutureBuilder(
        future: Api().getAddresses(user!.token.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return const CustomText(text: "check your internet");
            } else if (snapshot.data["data"].length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    "assets/noAddress.json",
                    repeat: false,
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(text: "No addresses found")
                ],
              );
            } else {
              User? user = context.read<UserDataProvider>().user;
              _controller.forward();
              return StatefulBuilder(builder: (context, changeState) {
                return Column(
                  children: List.generate(
                    (snapshot.data["data"] as List).length,
                    (index) => Slidable(
                      endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (value) async {
                                EssentialFunctions.loader(context);
                                var res = await Api().deleteUserAddress(
                                    user!.token.toString(),
                                    snapshot.data["data"][index]["id"]
                                        .toString());
                                if (res != false) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  setState(() {});
                                  Fluttertoast.showToast(
                                      msg: "Address deleted");
                                } else {
                                  Navigator.of(context, rootNavigator: true);
                                  Fluttertoast.showToast(
                                      msg: "Something went wrong");
                                }
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: CupertinoIcons.delete,
                            )
                          ]),
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: snapshot.data["data"][index]["id"]
                                        as int,
                                    groupValue: indexValue,
                                    onChanged: (value) {
                                      changeState(() {
                                        indexValue = snapshot.data["data"]
                                            [index]["id"] as int;
                                      });
                                    }),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: snapshot.data["data"][index]
                                            ["address"],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        alignment: Alignment.centerLeft,
                                      ),
                                      CustomText(
                                        text: snapshot.data["data"][index]
                                            ["state_name"],
                                        alignment: Alignment.centerLeft,
                                        fontSize: 18,
                                      ),
                                      CustomText(
                                        text: snapshot.data["data"][index]
                                            ["city_name"],
                                        alignment: Alignment.centerLeft,
                                        fontSize: 15,
                                      ),
                                      CustomText(
                                        text: snapshot.data["data"][index]
                                            ["phone"],
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: kBlack.withOpacity(0.4),
                              endIndent: 50,
                              indent: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
            }
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
