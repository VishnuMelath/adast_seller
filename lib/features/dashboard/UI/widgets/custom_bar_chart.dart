
import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/constants.dart';
import '../../../../ themes/themes.dart';
import '../../../../methods/common_methods.dart';
import '../../methods/linechart_data.dart';

Widget customBarChart(BuildContext context,
    {required DashboardBloc dashboardBloc,
    required ValueNotifier swipedRight}) {
  return ValueListenableBuilder(
      valueListenable: swipedRight,
      builder: (context, value, _) {

        var barGroups = createBarChartGroupData(
            groupDataByMonth(
                dashboardBloc.reservaions, dashboardBloc.chartEndDate),
            [],
            dashboardBloc);
        return Padding(
          padding: const EdgeInsets.only(top: 1.0, left: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      color: green,
                      size: 10,
                    ),
                    Text(
                      ' Completed',
                      style: greyMediumTextStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                     Icon(
                      Icons.circle,
                      color: red,
                      size: 10,
                    ),
                    Text(
                      ' Canceled',
                      style: greyMediumTextStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.circle,
                      color: grey,
                      size: 10,
                    ),
                    Text(
                      ' Reserved',
                      style: greyMediumTextStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                     dashboardBloc.chartEndDate=switchMonths(dashboardBloc.chartEndDate, 6);
                    swipedRight.value=!swipedRight.value;

                  } else if (details.primaryVelocity! < 0) {
                    for(int i=0;i<6;i++)
                    {
                      dashboardBloc.chartEndDate=addMonth(dashboardBloc.chartEndDate);
                    }
                   
                     swipedRight.value=!swipedRight.value;
                  }
                },
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  child: BarChart(BarChartData(
                    groupsSpace: 10,
                    alignment: BarChartAlignment.spaceEvenly,
                    maxY: dashboardBloc.maxy.toDouble(),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(drawVerticalLine: false),
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 60,
                          showTitles: true,
                          getTitlesWidget: (value, titleMeta) {
                            var year = (value % 10000).toInt();
                            var month1 = value ~/ 10000;
                            return SideTitleWidget(
                              axisSide: titleMeta.axisSide,
                              space: 4,
                              child: Column(
                                children: [
                                  Text(
                                    capitalize(month[month1]!),
                                    style: greySmallTextStyle,
                                  ),
                                  Text(
                                    '$year',
                                    style: greySmallTextStyle,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Center(
                                child: Text(
                              value.toInt().toString(),
                              style: greySmallTextStyle,
                            ));
                          },
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        );
      });
}
