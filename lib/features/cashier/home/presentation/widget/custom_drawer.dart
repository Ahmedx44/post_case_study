import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.15,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Haron',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading:
                const Icon(HugeIcons.strokeRoundedHome01, color: Colors.black),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            horizontalTitleGap: 10,
          ),
          ListTile(
            leading:
                const Icon(HugeIcons.strokeRoundedInvoice, color: Colors.black),
            title: const Text(
              'Invoices',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            horizontalTitleGap: 10,
          ),
          ListTile(
            leading: const Icon(HugeIcons.strokeRoundedGroupItems,
                color: Colors.black),
            title: const Text(
              'Items',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            horizontalTitleGap: 10,
          ),
          ListTile(
            leading: const Icon(HugeIcons.strokeRoundedSetting06,
                color: Colors.black),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            horizontalTitleGap: 10,
          ),
        ],
      ),
    );
  }
}
