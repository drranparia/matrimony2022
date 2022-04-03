import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrimony2022/pages/add_edit_screen.dart';
import 'package:matrimony2022/pages/favorite_screen.dart';
import 'package:matrimony2022/pages/search_screen.dart';
import 'package:matrimony2022/pages/user_list.dart';
import 'package:matrimony2022/widgets/light_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return MaterialApp(
      title: 'Matrimony2022',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    UserList(),
    SearchScreen(),
    FavoriteScreen(),
    AddEditScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: LightColor.lightBlue,
        title: Text(
          'Matrimony',
          style: TextStyle(
            fontFamily: 'WorkSans-SemiBold',
            color: Colors.white,
          ),
        ),
      ),
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: LightColor.lightGrey),
        ),
        child: CurvedNavigationBar(
          index: index,
          onTap: (index) => setState(() => this.index = index),
          color: LightColor.lightBlue,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: LightColor.lightBlue,
          height: 60,
          items: <Widget>[
            Icon(
              Icons.list,
              size: 20,
            ),
            Icon(
              Icons.search,
              size: 20,
            ),
            Icon(
              Icons.favorite,
              size: 20,
            ),
            Icon(
              Icons.add,
              size: 20,
            ),
          ],
          animationDuration: Duration(milliseconds: 1000),
          animationCurve: Curves.fastLinearToSlowEaseIn,
        ),
      ),
    );
  }
}
