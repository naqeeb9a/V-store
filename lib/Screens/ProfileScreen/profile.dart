import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            children: const [
              Icon(Icons.logout),
              SizedBox(
                width: 5,
              ),
              CustomText(text: "Logout")
            ],
          )),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Row(children: [
              const CircleAvatar(
                radius: 25,
                foregroundImage: NetworkImage(
                    "https://ps.w.org/metronet-profile-picture/assets/icon-256x256.png?rev=2464419"),
              ),
              Column(
                children: const [
                  CustomText(text: "name"),
                  CustomText(text: "email"),
                ],
              )
            ]),
          ),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Container(
                    color: Colors.red,
                    child: const CustomText(text: "Call us")),
                Container(
                    color: kGrey, child: const CustomText(text: "Mail us"))
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.web),
            title: CustomText(
              text: "Website",
            ),
          ),
          const ListTile(
            leading: Icon(Icons.contact_support),
            title: CustomText(
              text: "About us",
            ),
          ),
        ],
      ),
    );
  }
}
