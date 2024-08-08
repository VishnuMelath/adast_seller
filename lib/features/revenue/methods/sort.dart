import 'package:adast_seller/features/revenue/UI/widgets/revenue_tile.dart';
import 'package:adast_seller/features/revenue/bloc/revenue_bloc.dart';

import '../../../models/cloth_model.dart';

List<ClothModel> sortedList(RevenueBloc revenueBloc,List<ClothModel> items)
{
  List<ClothModel> filteredList=[];
  filteredList.addAll(items.where((element) => element.name.contains(revenueBloc.querry),));
  int sortOption=revenueBloc.sortOption;
  var temp = filteredList;
   if (sortOption != 0) {
      
      switch (sortOption) {
        //price ascending order
        case 1:
          temp.sort((a, b) => a.revenue.compareTo(b.revenue));
          break;
        //price desc order
        case 2:
          temp.sort((a, b) => b.revenue.compareTo(a.revenue));
          break;
        //date ascending order
        case 3:
          temp.sort((a, b) => totol(a.soldCount).compareTo(totol(b.soldCount)));
          break;
        //date desc order
        case 4:
          temp.sort((a, b) => totol(b.soldCount).compareTo(totol(a.soldCount)));
          break;
        //item left ascending order
        case 5:
          temp.sort((a, b) =>totalItemsLeft(a).compareTo(totalItemsLeft(b)));
          break;
        //itemleft desc order
        case 6:
          temp.sort((a, b) =>totalItemsLeft(b).compareTo(totalItemsLeft(a)));
          break;
        
        default:
          break;
      }
      filteredList=temp;
    }
  return filteredList;
}

int totalItemsLeft(ClothModel item)
{
  return (totol(item.size) - totol(item.soldCount));
}