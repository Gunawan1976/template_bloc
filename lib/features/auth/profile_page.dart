import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/core/enum.dart';

import '../../shared/widget/custom_text_widget.dart';
import 'login/presentation/bloc/login_bloc.dart';
import 'login/presentation/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    context.read<LoginBloc>().add(GetProfileRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: "Profile Pages",fontWeight: FontWeight.w600,),
        centerTitle: true,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state.status == LoadingState.loading) {
          return Center(child: const CircularProgressIndicator());
        }
        if (state.profile != null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50, // Half of the width/height
                    backgroundImage: NetworkImage(state.profile?.image ?? ""),
                  ),
                  SizedBox(height: 16.h,),
                  TextView(text: "${state.profile?.firstName ?? ""} ${state.profile?.lastName ?? ""}",fontWeight: FontWeight.w600),
                  SizedBox(height: 8.h,),
                  TextView(text:"@${state.profile?.username ?? ""}"),
                  SizedBox(height: 16.h,),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,

                              ),
                              child: Icon(Icons.email,color: Colors.black),
                            ),
                            title: TextView(text: state.profile?.email ?? ""),
                            onTap: () {

                            }
                        ),
                        Divider(),
                        ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,

                              ),
                              child: Icon(Icons.call,color: Colors.black),
                            ),
                            title: TextView(text: state.profile?.phone ?? ""),
                            onTap: () {

                            }
                        ),
                        Divider(),
                        ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                              child: Icon(Icons.location_pin,color: Colors.black),
                            ),
                            title: TextView(text: state.profile?.address?.address ?? ""),
                            onTap: () {

                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  ElevatedButton(onPressed: () {
                    context.read<LoginBloc>().add(LogoutButtonPressed());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ), child: TextView(text: "Logout",textColor: Colors.white,),)
                ],
              ),
            ),
          );
        }
        return const Text("No profile data");
      },)
    );
  }
}
