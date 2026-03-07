
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcc_remake_bloc/features/detail_produk/presentation/pages/single_produk_page.dart';
import 'package:vcc_remake_bloc/features/home_page/presentation/home/home_bloc.dart';
import 'package:vcc_remake_bloc/shared/widget/custom_text_widget.dart';

import '../../../../core/enum.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  @override
  void initState() {
    context.read<HomeBloc>().add(GetProduk());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: TextView(text: "Home Pages",fontWeight: FontWeight.w600,),
        centerTitle: true,

      ),
      body: BlocBuilder<HomeBloc,HomeState>(builder: (context, state) {
        if (state.status == LoadingState.loading) {
          return Center(child: const CircularProgressIndicator());
        }
        if (state.listProduk == null || state.listProduk!.isEmpty) {
          return const Center(child: Text("No produk data"));
        }
        if(state.produk != null){
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels == 0 &&
                    notification.metrics.axis == Axis.vertical) {
                  // Disable aksi ketika mencapai scroll paling atas
                  return true; // Menonaktifkan notifikasi lebih lanjut
                }
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent &&
                    notification.metrics.axis == Axis.vertical) {
                  if(state.page == state.produk!.total){

                  }else{
                    context.read<HomeBloc>().add(GetProduk());
                  }
                }
              }
              return true;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ListView.builder(
                itemCount: state.listProduk!.length + 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == state.listProduk!.length) {
                    if (state.hasReachedMax) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(
                          child: Text("No more data"),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: TextView(text: "Loading..."),
                        ),
                      );
                    }
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SingleProdukPage(id: state.listProduk?[index].id ?? 0,), // Kirim data user
                          ),
                        );
                      },
                      contentPadding: EdgeInsetsGeometry.all(8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      tileColor: Colors.grey.shade200,
                      leading: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(state.listProduk?[index].thumbnail ?? ""),
                              fit: BoxFit.contain,
                            )
                        ),
                      ),
                      title: TextView(text:state.listProduk?[index].title ?? "",fontWeight: FontWeight.w600),
                      subtitle: SizedBox(height:50.h,child: TextView(text: state.listProduk?[index].description ?? "",maxLines: 3,overflow: TextOverflow.ellipsis,)),
                      trailing: TextView(text:"\$${state.listProduk?[index].price ?? 0.0}"),
                    ),
                  );
                },),
            ),
          );
        }
        return const Text("No produk data");
      },)
    );
  }
}

