import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/SelectionScreen/selection_screen.dart';
import 'package:store/provider/cart_provider.dart';
import 'package:store/provider/store_provider.dart';

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
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StoreProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'store',
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(),
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.scaled,
              ),
            },
          ),
        ),
        home: const SelectionScreen(),
      ),
    );
  }
}
