
import 'package:flutter/material.dart';
import 'package:vcc_remake_bloc/shared/widget/custom_text_widget.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: "Home Pages"),
      ),
      body: Center(
        child: TextView(text: "Home Pages"),
      ),
    );
  }
}
