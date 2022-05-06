import 'package:flutter/material.dart';
import 'package:store/utils/colors.dart';
import 'package:store/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: kPink,
        label: InkWell(
          onTap: () async {},
          child: Row(
            children: const [
              CustomText(
                text: "Sign Out",
                textColor: kWhite,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.logout,
                color: kWhite,
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: kPink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: noColor,
                  foregroundImage: NetworkImage(
                      "https://www.kindpng.com/picc/m/780-7804962_cartoon-avatar-png-image-transparent-avatar-user-image.png"),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CustomText(
                      text: "studentName",
                      textColor: kWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: "studentClass",
                      textColor: kWhite,
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    canLaunchUrl(Uri.parse('tel:+923111144489')).then(
                        (value) => launchUrl(Uri.parse('tel:+923111144489')));
                  },
                  child: Container(
                    height: 70,
                    color: kBlack,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.phone,
                          color: kWhite,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: "CALL US",
                          textColor: kWhite,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    canLaunchUrl(Uri.parse('mailto:support@fscs.pk')).then(
                        (value) =>
                            launchUrl(Uri.parse('mailto:support@fscs.pk')));
                  },
                  child: Container(
                    height: 70,
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.mail,
                          color: kWhite,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: "MAIL US",
                          textColor: kWhite,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // profileRow(Icons.person, "Edit Profile"),
          // profileRow(Icons.location_on, "Locations"),
          // const Divider(
          //   color: kBlack,
          // ),
          profileRow(Icons.open_in_browser, "Website",
              function: () => canLaunchUrl(Uri.parse('https://fscs.pk/'))
                  .then((value) => launchUrl(Uri.parse('https://fscs.pk/')))),
          // profileRow(Icons.question_answer, "FAQ"),
          profileRow(Icons.info, "About Us",
              function: () => canLaunchUrl(Uri.parse("https://fscs.pk/about/"))
                  .then((value) =>
                      launchUrl(Uri.parse("https://fscs.pk/about/")))),
        ],
      ),
    );
  }

  profileRow(IconData icon, String text, {void Function()? function}) {
    return ListTile(
      onTap: function,
      leading: Icon(icon),
      title: CustomText(
        text: text,
        fontSize: 15,
      ),
    );
  }
}
