import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/features/auth/home_pages.dart';
import 'package:vcc_remake_bloc/features/auth/profile_page.dart';
import 'package:vcc_remake_bloc/features/search/presentation/pages/search_page.dart';

import '../core/enum.dart';
import '../shared/widget/custom_text_widget.dart';
import 'index/index_cubit.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BlocBuilder<IndexCubit, IndexState>(
        builder: (context, state) {
        return BottomNavigationBar(
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
          currentIndex: state.index,
          onTap: (value) {
            BlocProvider.of<IndexCubit>(context,).getNavBarItem(value);
          },
        );
      },),
      body: BlocBuilder<IndexCubit, IndexState>(builder: (context, state) {
        if (state.index == 0) {
          return HomePages();
        } else if (state.index == 1) {
          return SearchPage();
        } else if (state.index == 2) {
          return ProfilePage();
        }
        return Container();
      }),
    );
  }
}
