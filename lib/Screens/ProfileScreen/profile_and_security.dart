import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import "package:provider/provider.dart";
import 'package:store/Api/api.dart';
import 'package:store/Functionality/functionality.dart';
import 'package:store/Model/user_model.dart';
import 'package:store/Screens/ProfileScreen/edit_profile_screen.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_app_bar.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/custom_text.dart';

class ProfileAndSecurity extends StatefulWidget {
  final dynamic function;
  const ProfileAndSecurity({Key? key, this.function}) : super(key: key);

  @override
  State<ProfileAndSecurity> createState() => _ProfileAndSecurityState();
}

class _ProfileAndSecurityState extends State<ProfileAndSecurity> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
      appBar: BaseAppBar(
          title: "Profile",
          automaticallyImplyLeading: true,
          appBar: AppBar(),
          widgets: [
            if (image != null)
              GestureDetector(
                onTap: () async {
                  EssentialFunctions.loader(context);
                  var res = await Api().updateProfilePicture(
                      user!.id.toString(),
                      user.token.toString(),
                      base64Encode(File(image!.path).readAsBytesSync()));
                  if (res != false) {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pop(context, widget.function());
                    Fluttertoast.showToast(msg: "Profile picture updated");
                  } else {
                    KRoutes().pop(context);
                    Fluttertoast.showToast(msg: "Something went wrong");
                  }
                },
                child: Icon(
                  Icons.save_outlined,
                  color: kDarkPurple,
                ),
              )
            else
              const Center()
          ],
          appBarHeight: 50),
      body: FutureBuilder(
        future: Api().getProfile(user!.token.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Spacer(),
                  Stack(
                    children: [
                      image == null
                          ? CircleAvatar(
                              radius: 80,
                              foregroundImage: NetworkImage(
                                  "http://vstore.kissancorner.pk/public/${snapshot.data["avatar_original"]}"),
                              backgroundColor: kGrey,
                            )
                          : CircleAvatar(
                              radius: 80,
                              foregroundImage: FileImage(File(image!.path)),
                              backgroundColor: kGrey,
                            ),
                      Positioned(
                        right: 15,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {});
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: kDarkPurple,
                            radius: 20,
                            child: const Icon(
                              Icons.photo,
                              color: kWhite,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  const CustomText(
                    text: "Name :",
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: snapshot.data["name"],
                    fontSize: 25,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    text: "Email :",
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: snapshot.data["email"],
                    alignment: Alignment.centerLeft,
                    fontSize: 25,
                  ),
                  const Spacer(),
                  CustomButton(
                      text: "Edit Profile",
                      function: () {
                        KRoutes().push(
                            context,
                            EditProfileScreen(
                              userImage: snapshot.data["avatar_original"],
                              function: widget.function,
                            ));
                      },
                      color: kDarkPurple),
                  const Spacer(),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
