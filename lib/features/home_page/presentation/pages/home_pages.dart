
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: TextView(text: "Home Pages",fontWeight: FontWeight.w600,),
        centerTitle: true,

      ),
      body: BlocBuilder<HomeBloc,HomeState>(builder: (context, state) {
        if (state.status == LoadingState.loading) {
          return Center(child: const CircularProgressIndicator());
        }
        if(state.produk != null){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: NotificationListener<ScrollNotification>(
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
                    // if (absensiController.meta.value.totalPage! ==
                    //     absensiController.currentPage.value) {} else {
                    //   absensiController.currentPage.value++;
                    //   absensiController.getAbsensiList(
                    //       status: selectedStatus,
                    //       area: DateFormat("yyyy-MM").format(
                    //           selectedDate));
                    // }
                    if(state.page == state.produk!.total){

                    }else{
                      context.read<HomeBloc>().add(GetProduk());
                    }
                  }
                }
                return true;
              },
              child:  ListView.builder(
                itemCount: state.listProduk?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: ListTile(
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
            )
          );
        }
        return const Text("No produk data");
      },)
    );
  }
}

