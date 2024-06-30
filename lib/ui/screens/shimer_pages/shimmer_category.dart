import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategory extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 50,),
                          Row(
                            children: [
                              Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.25),
                                    highlightColor: Colors.white.withOpacity(0.6),
                                    period: const Duration(seconds: 1),
                                    child: Container(
                                      height: 112,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey.withOpacity(0.9)
                                      ),
                                    ),
                                  )
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.25),
                                    highlightColor: Colors.white.withOpacity(0.6),
                                    period: const Duration(seconds: 1),
                                    child: Container(
                                      height: 112,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey.withOpacity(0.9)
                                      ),
                                    ),
                                  )
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.25),
                                    highlightColor: Colors.white.withOpacity(0.6),
                                    period: const Duration(seconds: 1),
                                    child: Container(
                                      height: 112,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey.withOpacity(0.9)
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.25),
                            highlightColor: Colors.white.withOpacity(0.6),
                            period: const Duration(seconds: 1),
                            child: Container(
                              height: 118,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.9)
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.25),
                            highlightColor: Colors.white.withOpacity(0.6),
                            period: const Duration(seconds: 1),
                            child: Container(
                              height: 118,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.9)
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.25),
                            highlightColor: Colors.white.withOpacity(0.6),
                            period: const Duration(seconds: 1),
                            child: Container(
                              height: 118,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.9)
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.25),
                            highlightColor: Colors.white.withOpacity(0.6),
                            period: const Duration(seconds: 1),
                            child: Container(
                              height: 118,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.9)
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.25),
                            highlightColor: Colors.white.withOpacity(0.6),
                            period: const Duration(seconds: 1),
                            child: Container(
                              height: 118,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.9)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),
        )
    );
  }
}