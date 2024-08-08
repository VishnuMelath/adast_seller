
import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:adast_seller/models/reservation_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Map<String, Map<String, int>> groupDataByMonth(List<ReservationModel> data,DateTime endDate) {
  final groupedData = <String, Map<String, int>>{};
  var startDate=switchMonths(endDate, 6);
  var tempDate=startDate;
  String endkey='${endDate.month}${endDate.year}';
  String tempkey='${startDate.month}${startDate.year}';
  while(tempkey!=endkey)
  {
    groupedData[tempkey]={
      ReservationStatus.purchased.name: 0,
      ReservationStatus.cancelled.name: 0,
      ReservationStatus.reserved.name: 0,
    };
    tempDate=addMonth(tempDate);
    tempkey='${tempDate.month}${tempDate.year}';
  }
groupedData[tempkey]={
      ReservationStatus.purchased.name: 0,
      ReservationStatus.cancelled.name: 0,
      ReservationStatus.reserved.name: 0,
    };

  for (final dataPoint in data) {
    final month = dataPoint.reservationTime.month.toString();
    final year = dataPoint.reservationTime.year.toString();
    final status = dataPoint.status;
    // groupedData['$month$year'] ??= {};
    // groupedData['$month$year']![status] ??= 0;
    // groupedData['$month$year']![ReservationStatus.reserved.name] ??= 0;
    if(groupedData.containsKey('$month$year'))
    {if (status == ReservationStatus.reserved.name) {
      groupedData['$month$year']![ReservationStatus.reserved.name] =
          groupedData['$month$year']![ReservationStatus.reserved.name]! + 1;
    } else {
      groupedData['$month$year']![ReservationStatus.reserved.name] =
          groupedData['$month$year']![ReservationStatus.reserved.name]! + 1;
      groupedData['$month$year']![status] =
          groupedData['$month$year']![status]! + 1;
    }}
  }
  return groupedData;
}

List<BarChartGroupData> createBarChartGroupData(
    Map<String, Map<String, int>> map,
    List<BarChartGroupData> list,
    DashboardBloc dashboardBloc) {
      
      bool changed=false;
  map.forEach(
    (key, value) {
      value.forEach(
        (key, value) {
          if (value > dashboardBloc.maxy) {
            dashboardBloc.maxy = value;
            changed=true;
          }
        },
      );
    },
  );
  if (changed) {
  var temp = dashboardBloc.maxy % 5;
  temp = 10 - temp;
  
  dashboardBloc.maxy += temp;
}
  map.forEach(
    (key, value) {
      List<BarChartRodData> temp = [];
      value.forEach(
        (key1, value1) {
          temp.add(BarChartRodData(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: key1 == ReservationStatus.cancelled.name
                  ? Colors.red[800]
                  : key1 == ReservationStatus.purchased.name
                      ? grey
                      : green,
              toY: value1.toDouble()));
        },
      );
      list.add(BarChartGroupData(
        barsSpace: 0,
        x: int.parse(key),
        barRods: [...temp],
      ));
    },
  );
  return list;
}

DateTime addMonth(DateTime date)
{
  var year=date.year;
  var month=date.month;
  if(month+1==13)
  {
    year=year+1;
    month=1;
  }
  else
  {
    month++;
  }
  return DateTime(year,month);
}