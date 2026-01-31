
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcc_remake_bloc/core/constant.dart';
import 'package:vcc_remake_bloc/core/utils/secure_storage_util.dart';
import 'package:vcc_remake_bloc/features/index_page.dart';
import 'package:vcc_remake_bloc/shared/widget/custom_text_widget.dart';

import 'login/presentation/bloc/login_bloc.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: "Home Pages",fontWeight: FontWeight.w600,),
        centerTitle: true,

      ),
      body: Center(
        child: TextView(text: "Home Page"),
      ),
    );
  }
}

