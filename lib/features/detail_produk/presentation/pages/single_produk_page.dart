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
              success: (data) =>
                  Center(
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
                success: (data) => Padding(
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
                          horizontal: 16.0.w, vertical: 16.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(width: 8.w,),
                              StarRating(
                                color: Colors.amber,
                                rating: data.rating ?? 0.0,
                                allowHalfRating: false,
                              ),
                              SizedBox(width: 8.w,),
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
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          TextView(
                            text:data.description ?? "",
                            textAlign: TextAlign.justify,
                          ),
                          // SizedBox(height: 8.h,),
                          // Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
                error: (message) => Center(child: Text("Error: $message")));
          },)
    );
  }
}
