import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store/Api/api.dart';
import 'package:store/Functionality/functionality.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/app_routes.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/widgets.dart';

import '../../Model/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final String userImage;
  final dynamic function;
  const EditProfileScreen({Key? key, required this.userImage, this.function})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserDataProvider>().user;
    return Scaffold(
      appBar: BaseAppBar(
          title: "Edit profile",
          automaticallyImplyLeading: true,
          appBar: AppBar(),
          widgets: const [],
          appBarHeight: 50),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 80,
              foregroundImage: NetworkImage(
                  "http://vstore.kissancorner.pk/public/${widget.userImage}"),
            ),
            const Spacer(),
            CustomTextField(controller: _name, hintText: "Name"),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: _password,
              hintText: "Password",
              isPassword: true,
              suffixIcon: const Icon(Icons.visibility_outlined),
            ),
            const Spacer(),
            CustomButton(
                text: "Update Profile",
                function: () async {
                  if (_name.text.isEmpty || _password.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Fields can't be empty");
                  } else {
                    EssentialFunctions.loader(context);
                    var res = await Api().updateProfile(user!.id.toString(),
                        _name.text, _password.text, user.token.toString());
                    if (res != false) {
                      Navigator.of(context, rootNavigator: true).pop();
                      KRoutes().pop(context);
                      Navigator.pop(context, widget.function());
                      Fluttertoast.showToast(msg: "Profile updated");
                    } else {
                      Navigator.of(context, rootNavigator: true);
                      Fluttertoast.showToast(msg: "Something went wrong");
                    }
                  }
                },
                color: kDarkPurple),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    super.dispose();
  }
}
