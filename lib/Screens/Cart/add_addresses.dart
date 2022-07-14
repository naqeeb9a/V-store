import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Functionality/functionality.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

import '../../../widgets/custom_button.dart';
import '../../provider/user_data_provider.dart';

class AddAddress extends StatefulWidget {
  final dynamic function;
  const AddAddress({Key? key, this.function}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _postal = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  String? cityId;
  String? stateId;
  String? countryId;
  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        title: "Add Address",
        widgets: const [],
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const CustomText(
                text:
                    "Please add your current address where the product can be delivered",
                alignment: Alignment.centerLeft,
                fontSize: 18,
                alignText: TextAlign.left,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const CustomText(text: "Select a Country :"),
                          titleTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: FutureBuilder(
                              future:
                                  Api().getCountries(user!.token.toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                    itemCount: snapshot.data["data"].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _country.text = snapshot.data["data"]
                                                  [index]["name"]
                                              .toString();
                                          countryId = snapshot.data["data"]
                                                  [index]["id"]
                                              .toString();
                                          KRoutes().pop(context);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: kDarkPurple),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ListTile(
                                            title: CustomText(
                                                text: snapshot.data["data"]
                                                    [index]["name"]),
                                            style: ListTileStyle.drawer,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      });
                },
                child: CustomTextField(
                  controller: _country,
                  hintText: "Country",
                  enable: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const CustomText(text: "Select a City :"),
                          titleTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: FutureBuilder(
                              future: Api().getCities(user!.token.toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                    itemCount: snapshot.data["data"].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _city.text = snapshot.data["data"]
                                                  [index]["name"]
                                              .toString();
                                          stateId = snapshot.data["data"][index]
                                                  ["state_id"]
                                              .toString();
                                          cityId = snapshot.data["data"][index]
                                                  ["id"]
                                              .toString();
                                          KRoutes().pop(context);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: kDarkPurple),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ListTile(
                                            title: CustomText(
                                                text: snapshot.data["data"]
                                                    [index]["name"]),
                                            style: ListTileStyle.drawer,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      });
                },
                child: CustomTextField(
                  controller: _city,
                  hintText: "City",
                  enable: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _address,
                hintText: "Address",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _postal,
                hintText: "Postal code",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _phone,
                hintText: "Phone",
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: CustomButton(
                    text: "Add Address",
                    function: () async {
                      if (_country.text.isEmpty ||
                          _city.text.isEmpty ||
                          _address.text.isEmpty ||
                          _postal.text.isEmpty ||
                          _phone.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Fill all fields");
                      } else {
                        EssentialFunctions.loader(context);
                        var res = await Api().addUserAddress(
                            user!.token.toString(),
                            user.id.toString(),
                            _address.text,
                            countryId.toString(),
                            stateId.toString(),
                            cityId.toString(),
                            _postal.text,
                            _phone.text);
                        if (res != false) {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pop(context, widget.function());
                          Fluttertoast.showToast(msg: "Address added");
                        } else {
                          Navigator.of(context, rootNavigator: true).pop();
                          Fluttertoast.showToast(msg: "Something went wrong");
                        }
                      }
                    },
                    color: kPink,
                    height: 50,
                    minWidth: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
