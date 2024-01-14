// import 'package:flutter/material.dart';
// import 'package:project/pages/home_page.dart';
// import 'package:project/pages/profile_page.dart';
//
// class WidgetTree extends StatefulWidget {
//   final Function(Locale) setLocale; // Dodaj ten argument
//   const WidgetTree({super.key, required this.setLocale}); // Uaktualnij konstruktor
//
//   @override
//   State<WidgetTree> createState() => _WidgetTreeState();
// }
//
// class _WidgetTreeState extends State<WidgetTree> {
//   int currentPage = 0;
//
//   late final List<Widget> pages = [
//     HomePages(setLocale: widget.setLocale), // Użyj funkcji setLocale
//     const ProfilePage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages.elementAt(currentPage),
//       bottomNavigationBar: NavigationBar(
//           destinations: const [
//             NavigationDestination(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//           selectedIndex: currentPage,
//           onDestinationSelected: (int value) {
//             setState(() {
//               currentPage = value;
//             });
//           }),
//     );
//   }
// }
