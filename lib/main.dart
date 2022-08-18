import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/IntroScreens/splash_screen.dart';
import 'package:store/provider/sub_category_provider.dart';
import 'package:store/provider/store_provider.dart';
import 'package:store/provider/user_data_provider.dart';
import 'package:store/utils/colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SubCategoryProvider(id: -1),
        ),
        ChangeNotifierProvider(
          create: (context) => StoreProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserDataProvider())
      ],
      child: MaterialApp(
        title: 'store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
            colorScheme: ColorScheme.light(primary: kDarkPurple),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            )).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.scaled,
              ),
            },
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
