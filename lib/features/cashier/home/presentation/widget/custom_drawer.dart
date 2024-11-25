import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SidebarX(
        controller: SidebarXController(selectedIndex: 0),
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          selectedTextStyle: const TextStyle(color: Colors.black),
          itemTextPadding: const EdgeInsets.symmetric(horizontal: 20),
          selectedItemTextPadding: const EdgeInsets.symmetric(horizontal: 20),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.1),
          ),
          iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.7),
            size: 24,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.black,
            size: 24,
          ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 60,
        ),
        headerBuilder: (context, extended) {
          return const SizedBox(
            height: 80,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Haron'),
            ),
          );
        },
        items: [
          SidebarXItem(
            icon: HugeIcons.strokeRoundedHome01,
            label: 'Home',
            onTap: () {
              debugPrint('Home');
            },
          ),
          const SidebarXItem(
            icon: HugeIcons.strokeRoundedSearch01,
            label: 'Search',
          ),
          const SidebarXItem(
            icon: HugeIcons.strokeRoundedPeerToPeer01,
            label: 'People',
          ),
          SidebarXItem(
            icon: HugeIcons.strokeRoundedFavourite,
            label: 'Favorites',
            selectable: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
