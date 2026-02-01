import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/widget/custom_text_widget.dart';
import '../bloc/single_produk_bloc.dart';

class SingleProdukPage extends StatefulWidget {
  final int id;

  const SingleProdukPage({super.key, required this.id});

  @override
  State<SingleProdukPage> createState() => _SingleProdukPageState();
}

class _SingleProdukPageState extends State<SingleProdukPage> {
  @override
  void initState() {
    context.read<SingleProdukBloc>().add(
      SingleProdukEvent.fetch(id: widget.id.toString()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(
          text: "Single Produk Pages",
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SingleProdukBloc, SingleProdukState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text("Init")),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (data,counter) => Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 230.h,
                    child: Image.network(data.thumbnail ?? ""),
                  ),
                ],
              ),
            ),
            error: (message) => Center(child: Text("Error: $message")),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<SingleProdukBloc, SingleProdukState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text("Init")),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (data,counter) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(color: Colors.black26),
                ),
                height: 0.53.sh,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                    vertical: 16.0.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextView(
                            text: data.title ?? "",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          Row(
                            children: [
                              TextView(
                                text: "\$${data.price ?? 0.0}",
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                textColor: Colors.blue,
                              ),
                              SizedBox(width: 8.w),
                              StarRating(
                                color: Colors.amber,
                                rating: data.rating ?? 0.0,
                                allowHalfRating: false,
                              ),
                              SizedBox(width: 8.w),
                              TextView(
                                text: (data.rating ?? 0.0).toString(),
                                textColor: Colors.grey,
                              ),
                              TextView(
                                text: " (${data.reviews?.length ?? 0} reviews)",
                                textColor: Colors.grey,
                              ),
                            ],
                          ),
                          Divider(),
                          TextView(
                            text: "Description",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          TextView(
                            text: data.description ?? "",
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 8.h),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextView(
                                text: "Quantity",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              Container(
                                width: 100.w,
                                height: 25.h,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  // border: Border.all(color: Colors.black26),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        context.read<SingleProdukBloc>()
                                            .add(const SingleProdukEvent.decrement());},
                                      child: Container(
                                        height: double.infinity,
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            bottomLeft: Radius.circular(16),
                                          ),
                                          // border: Border.all(color: Colors.black26),
                                        ),
                                        child: Center(child: TextView(text: "-",fontSize: 16.sp,fontWeight: FontWeight.bold,)),
                                      ),
                                    ),
                                    TextView(text: "$counter",fontSize: 16.sp,fontWeight: FontWeight.bold),
                                    InkWell(
                                      onTap: () {
                                        if (counter == data.stock ) {

                                        }else{
                                          context.read<SingleProdukBloc>()
                                              .add(const SingleProdukEvent.increment());
                                        }

                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(16),
                                            bottomRight: Radius.circular(16),
                                          ),
                                          // border: Border.all(color: Colors.black26),
                                        ),
                                        child: Center(child: TextView(text: "+",fontSize: 16.sp,fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextView(
                                text: "Tags",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: 30.h,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: data.tags?.length ?? 0,
                                  itemBuilder: (context, index) =>
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(padding: EdgeInsetsGeometry.all(8),
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withValues(alpha: 0.2),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                            // border: Border.all(color: Colors.black26),
                                          ),
                                          child: Center(child: TextView(
                                            text: data.tags?[index] ?? "", textColor: Colors.white,)),
                                        ),
                                      ),),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Divider(),
                      ElevatedButton(onPressed: () {
                        
                      }, style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
                            backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ), child: TextView(text: "Buy Now",textColor: Colors.white,)
                      )
                    ],
                  ),
                ),
              ),
            ),
            error: (message) => Center(child: Text("Error: $message")),
          );
        },
      ),
    );
  }
}
