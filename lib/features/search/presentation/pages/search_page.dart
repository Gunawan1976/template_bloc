import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widget/custom_texfield_widget.dart';
import '../../../../shared/widget/custom_text_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchText= TextEditingController();
  Timer? _debounce;

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: TextView(text: "Search Pages",fontWeight: FontWeight.w600,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade200,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
              child: EditText(
                prefixIcon: Icon(Icons.search,color: Colors.grey,size: 30.sp,),
                hintTextField: "Search Products...",
                hintTextSize: 16,
                keyboardType: TextInputType.text,
                onChanged: (value) {

                },
                fillColor: Colors.white,
                customController: searchText,
                titleTextField: "Search",
                borderRadius: 25,
              ),
            ),
          ),
          Divider(height: 3.h,),
        ],
      )
    );
  }
}
