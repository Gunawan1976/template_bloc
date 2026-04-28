import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class IndexPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const IndexPage({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24.sp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 24.sp),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24.sp),
            label: 'Profile',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
