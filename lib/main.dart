import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/pages/personal_page.dart';
import 'package:to_do_app/pages/work_page.dart';

void main() async {
  await Hive.initFlutter();
  var homebox = await Hive.openBox('homemybox');
  var personalmybox = await Hive.openBox('personalmybox');
  var workmybox = await Hive.openBox('workmybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: navigationPage(),
    );
  }
}

class navigationPage extends StatefulWidget {
  const navigationPage({super.key});

  @override
  State<navigationPage> createState() => _navigationPageState();
}

class _navigationPageState extends State<navigationPage> {

  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    PersonalPage(),
    WorkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.lightBlueAccent,
          indicatorColor: Colors.lightBlue[400],
          elevation: 10.0,
          labelTextStyle: MaterialStateProperty.all(TextStyle(color: Colors.white), // Set label text color to white
          ),
        ),
        child: NavigationBar(

          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home Task',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: 'Personal Task',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.work,
                color: Colors.white,
              ),
              label: 'Work Task',
            ),
          ],
        ),
      ),
    );
  }
}


