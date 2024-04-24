import 'package:flutter/material.dart';
import 'package:fypdashboard/models/sidebar_item.dart';
import 'package:fypdashboard/routes/route.dart';

import '../../utils/storage_keys.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    var gymSidebar = [
      Image.asset('images/output-onlinepngtools.png', height: 150, width: 150),
      const SizedBox(height: 10),
      SidebarItem(
        title: 'Home',
        icon: Icons.home,
        onTap: () => Navigator.pushNamed(context, AppRoutes.homePage),
      ),
      SidebarItem(
        title: 'Gyms',
        icon: Icons.people,
        onTap: () => Navigator.pushNamed(context, AppRoutes.gymPage),
      ),
      SidebarItem(
        title: 'Members',
        icon: Icons.people,
        onTap: () => Navigator.pushNamed(context, AppRoutes.memberTable),
      ),
      SidebarItem(
        title: 'Payments',
        icon: Icons.payments,
        onTap: () => Navigator.pushNamed(context, AppRoutes.adminPayments),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SidebarItem(
          title: 'Logout',
          icon: Icons.logout_outlined,
          onTap: () => Navigator.pushNamed(context, AppRoutes.logOutPage),
        ),
      ),
    ];

    var adminSidebar = [
      Image.asset('images/output-onlinepngtools.png', height: 150, width: 150),
      const SizedBox(height: 10),
      SidebarItem(
        title: 'Home',
        icon: Icons.home,
        onTap: () => Navigator.pushNamed(context, AppRoutes.adminHome),
      ),
      SidebarItem(
        title: 'Gyms',
        icon: Icons.people,
        onTap: () => Navigator.pushNamed(context, AppRoutes.adminGyms),
      ),
      SidebarItem(
        title: 'Members',
        icon: Icons.people,
        onTap: () => Navigator.pushNamed(context, AppRoutes.adminMembers),
      ),
      SidebarItem(
        title: 'Payments',
        icon: Icons.payments,
        onTap: () => Navigator.pushNamed(context, AppRoutes.adminPayments),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SidebarItem(
          title: 'Logout',
          icon: Icons.logout_outlined,
          onTap: () => Navigator.pushNamed(context, AppRoutes.logOutPage),
        ),
      ),
    ];
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        // children: [
        // Image.asset('images/output-onlinepngtools.png', height: 59, width: 50),
        // const SizedBox(height: 20 ),
        // Column(
        children: StorageHelper.getUserType() == 0 ? adminSidebar : gymSidebar,
        // )
        // ],
      ),
    );
  }
}
