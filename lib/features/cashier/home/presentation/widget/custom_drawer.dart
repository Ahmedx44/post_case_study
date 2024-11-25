import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: SidebarX(
        showToggleButton: false,
        controller: SidebarXController(selectedIndex: 0),
        theme: SidebarXTheme(
            margin: const EdgeInsets.all(0),
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
            width: 50),
        headerBuilder: (context, extended) {
          return const Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Haron',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          );
        },
        items: const [
          SidebarXItem(
            icon: HugeIcons.strokeRoundedHome01,
            label: 'Home',
          ),
          SidebarXItem(
            icon: HugeIcons.strokeRoundedSearch01,
            label: 'Search',
          ),
          SidebarXItem(
            icon: HugeIcons.strokeRoundedPeerToPeer01,
            label: 'People',
          ),
          SidebarXItem(
            icon: HugeIcons.strokeRoundedFavourite,
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
