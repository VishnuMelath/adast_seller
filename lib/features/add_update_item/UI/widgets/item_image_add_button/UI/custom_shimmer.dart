import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget customShimmer=Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );