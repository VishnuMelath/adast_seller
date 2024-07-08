
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/custom_snackbar.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/category_widget/bloc/category_bloc.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryBloc categoryBloc;
  final void Function(String?)? onChanged;
  const CategoryWidget({super.key, required this.onChanged,required this.categoryBloc});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    TextEditingController newCategoryController = TextEditingController();

    return Center(
      child: BlocConsumer<CategoryBloc, CategoryState>(
        bloc: categoryBloc,
        listener: (context, state) {
          if (state is CategoryErrorState) {
            customSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const CircularProgressIndicator();
          } else {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width*0.97 ,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Category',
                        style: largeBlackTextStyle,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  CustomTextfield(
                    login: true,
                    label: 'Search',
                    controller: searchController,
                    onChanged: (value) {
                      context
                          .read<CategoryBloc>()
                          .add(CategorySearchEvent(query: value));
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children: categoryBloc.catagory.map(
                        (e) {
                          return GestureDetector(
                            onTap: () {
                              if (onChanged != null) {
                                onChanged!(e);
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                    value: e,
                                    groupValue:categoryBloc
                                        .selectedValue,
                                    onChanged: onChanged),
                                Text(
                                  e,
                                  style: blackTextStyle,
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: newCategoryController,
                      decoration: InputDecoration(
                          hintText: 'add custom category',
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (newCategoryController.text
                                    .trim()
                                    .isNotEmpty) {
                                  searchController.clear();
                                  categoryBloc.add(
                                      CatagoryAddEvent(
                                          category:
                                              newCategoryController.text));
                                  newCategoryController.clear();
                                } else {
                                  customSnackBar(
                                      context, 'please type the category');
                                }
                              },
                              icon: const Icon(Icons.add)),
                          border: const OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
