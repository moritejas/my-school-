import 'package:flutter/material.dart';
import 'dart:math';
import 'package:animated_sidebar/animated_sidebar.dart';

class NewSideBar extends StatefulWidget {
  const NewSideBar({super.key});

  @override
  State<NewSideBar> createState() => _NewSideBarState();
}

class _NewSideBarState extends State<NewSideBar> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeTab = 0;

  final List<SidebarItem> items = [
    SidebarItem(
      icon: Icons.home,
      text: 'Home',
    ),
    SidebarItem(
      icon: Icons.notifications,
      text: 'Notifications',
    ),
    SidebarItem(
      icon: Icons.person,
      text: 'Management',
      children: [
        SidebarChildItem(
          icon: Icons.person,
          text: 'Users',
        ),
        SidebarChildItem(
          icon: Icons.verified_user,
          text: 'Roles',
        ),
        SidebarChildItem(
          icon: Icons.key,
          text: 'Permissions',
        ),
      ],
    ),
    SidebarItem(
      icon: Icons.abc,
      text: 'Integrations',
    ),
    SidebarItem(
      icon: Icons.settings,
      text: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            AnimatedSidebar(
              margin: const EdgeInsets.fromLTRB(10, 15, 0, 15),
              expanded: MediaQuery.of(context).size.width > 600,
              items: items,
              selectedIndex: activeTab,
              autoSelectedIndex: false,
              onItemSelected: (index) => setState(() => activeTab = index),
              duration: const Duration(milliseconds: 500),
              frameDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.repeated,
                  colors: [
                    Color.fromRGBO(66, 66, 74, 1),
                    Color.fromRGBO(25, 25, 25, 1),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(66, 66, 66, 0.75),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              minSize: 90,
              maxSize: 250,
              itemIconSize: 26,
              itemIconColor: Colors.white,
              itemHoverColor: Colors.grey.withOpacity(0.3),
              itemSelectedColor: Colors.grey.withOpacity(0.3),
              itemTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
              itemSelectedBorder: const BorderRadius.all(
                Radius.circular(5),
              ),
              itemMargin: 16,
              itemSpaceBetween: 10,
              headerIcon: Icons.ac_unit_sharp,
              headerIconSize: 30,
              headerIconColor: Colors.amberAccent,
              headerTextStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              headerText: ' Example',
            ),
            Expanded(
              child: _buildPage(activeTab),
            ),
          ],
        ),
      ),
    );
  }

  //minimal version
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //     body: Row(
  //       children: [
  //         AnimatedSidebar(
  //           expanded: MediaQuery.of(context).size.width > 600,
  //           items: items,
  //           selectedIndex: activeTab,
  //           onItemSelected: (index) =>
  //               setState(() => activeTab = index),
  //           headerIcon: Icons.ac_unit_sharp,
  //           headerIconColor: Colors.amberAccent,
  //           headerText: 'Example',
  //         ),
  //         Center(
  //           child: Text(
  //             'Page: $activeTab',
  //             style: Theme.of(context).textTheme.headline3,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPage(int idx) {
    // return a page full of skeleton cards
    return Wrap(
      children: List.generate(8, (index) {
        double width = idx % 2 == 0 ? double.infinity : 500;
        int count = Random().nextInt(2) + 3;
        return Container(
            margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            width: width,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            // create a skeleton card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < count; i++)
                  Container(
                    width: Random().nextInt(100).toDouble() + 200,
                    height: i == 0 ? 30 : 20,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
              ],
            ));
      }),
    );
  }
}
