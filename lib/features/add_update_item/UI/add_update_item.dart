import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/custom_button.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/category_widget/UI/category.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/category_widget/bloc/category_bloc.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/custom_drop_down.dart';
import 'package:adast_seller/custom_widgets/custom_snackbar.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/item_image_add_button/UI/item_image_add_widget.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/item_image_add_button/bloc/itemimageadd_bloc.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/multi_drop_down/UI/multi_select.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/multi_drop_down/bloc/multi_dd_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_textfield2.dart';
import '../bloc/add_update_bloc.dart';

class AddItem extends StatelessWidget {
  final ClothModel? clothModel;
  const AddItem({super.key, this.clothModel});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();

    //text editing controllers
    TextEditingController nameController =
        TextEditingController(text: clothModel?.name);
    TextEditingController descriptionController =
        TextEditingController(text: clothModel?.description);
    TextEditingController brandController =
        TextEditingController(text: clothModel?.brand);
    TextEditingController priceController =
        TextEditingController(text: clothModel?.price.toString());
    TextEditingController tagsController =
        TextEditingController(text: clothModel?.tags);
    TextEditingController metaTitleController =
        TextEditingController(text: clothModel?.metaTitle);
    TextEditingController metaDescriptionController =
        TextEditingController(text: clothModel?.metaDescription);
    TextEditingController materialController =
        TextEditingController(text: clothModel?.material);
    TextEditingController categoryController =
        TextEditingController(text: clothModel?.category);

    String fit = clothModel?.fit ?? '';

    //blocs
    ItemimageaddBloc itemimageaddBloc = ItemimageaddBloc();
    AddBloc addUpdateBloc = AddBloc();
    MultiDdBloc multiDdBloc = MultiDdBloc();
    CategoryBloc categoryBloc = CategoryBloc();
    categoryBloc.add(CategoryInitialEvent());

    if (clothModel?.size != null) {
      multiDdBloc.countMap = clothModel?.size ?? {};
      multiDdBloc.reservable=clothModel?.reservableCount??{};
    }

    if (clothModel?.images != null) {
      itemimageaddBloc.images = clothModel?.images ?? [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          clothModel == null ? 'Add Item' : 'Update Item',
          style: greenTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Column(
              children: [
                CustomTextfield2(
                    label: 'item name', controller: nameController),
                CustomTextfield2(
                  label: 'description',
                  controller: descriptionController,
                  maxLines: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'category',
                        style: blackTextStyle,
                      ),
                      TextFormField(
                        readOnly: true,
                        showCursor: false,
                        controller: categoryController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.arrow_right),
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 10),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.none,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Scaffold(
                                    body: CategoryWidget(
                                      categoryBloc: categoryBloc,
                                      onChanged: (category) {
                                        categoryController.text =
                                            category ?? '';
                                        categoryBloc.add(CategorySelectedEvent(
                                            category: category));
                                      },
                                    ),
                                  ));
                        },
                      ),
                    ],
                  ),
                ),
                // Visibility(
                //   visible: category == 'others',
                //   child: CustomTextfield2(
                //       label: 'category', controller: categoryController),
                // ),
                CustomDropDown(
                    items: fits,
                    selectedValue: clothModel?.fit ?? '',
                    onChanged: (value) {
                      if (value != null) {
                        fit = value;
                      }
                    },
                    label: 'fit'),
                CustomDropDown(
                    items: fabric,
                    selectedValue: clothModel?.material ?? '',
                    onChanged: (value) {
                      if (value != null) {
                        materialController.text = value;
                      }
                    },
                    label: 'material'),
                BlocProvider(
                  create: (context) => itemimageaddBloc,
                  child: const ItemImageAddWidget(),
                ),
                CustmMultiselectionDropdownT(
                    onOptionRemoved: (index, values) {
                      multiDdBloc
                          .add(MultiDdUnSelectedEvent(size: values.label));
                    },
                    onOptionSelected: (values) {
                      multiDdBloc.add(MultiDdSelectedEvent(
                          sized: values
                              .map(
                                (e) => e.label,
                              )
                              .toList()));
                    },
                    multiDdBloc: multiDdBloc),
                CustomTextfield2(label: 'brand', controller: brandController),
                CustomTextfield2(
                  label: 'price',
                  controller: priceController,
                  number: true,
                ),
                CustomTextfield2(label: 'tags', controller: tagsController),
                CustomTextfield2(
                    label: "meta title", controller: metaTitleController),
                CustomTextfield2(
                  label: 'meta description',
                  controller: metaDescriptionController,
                  maxLines: 4,
                ),
                BlocConsumer<AddBloc, AddState>(
                  listener: (context, state) {
                    if (state is AddNotCompletedState) {
                      customSnackBar(context, state.message);
                    } else if (state is AddUpadateSavedSuccessState) {
                      customSnackBar(context, 'Saved successfully');
                      Navigator.pop(context, addUpdateBloc.clothModel);
                    }
                  },
                  bloc: addUpdateBloc,
                  builder: (context, state) {
                    if (state is SaveButtonPressedState) {
                      return CustomButton(
                        onTap: () {},
                        text: '',
                        loading: true,
                      );
                    } else {
                      return CustomButton(
                        onTap: () {
                          addUpdateBloc.clothModel = clothModel ??
                              ClothModel(
                                  revenue: 0,
                                  date: DateTime.now(),
                                  sellerID: '',
                                  name: '',
                                  description: '',
                                  category: '',
                                  fit: '',
                                  size: {},
                                  images: [],
                                  brand: '',
                                  material: '',
                                  price: 0,
                                  tags: '',
                                  metaTitle: '',
                                  metaDescription: '',
                                  reservableCount: {});
                          if (formkey.currentState!.validate()) {
                            addUpdateBloc.clothModel.sellerID =
                                context.read<LoginBloc>().sellerModel!.email;
                            addUpdateBloc.clothModel.name = nameController.text;
                            addUpdateBloc.clothModel.description =
                                descriptionController.text;
                            addUpdateBloc.clothModel.category =
                                categoryController.text;
                            addUpdateBloc.clothModel.fit = fit;
                            addUpdateBloc.clothModel.size =
                                multiDdBloc.countMap;
                            addUpdateBloc.clothModel.reservableCount =
                                multiDdBloc.reservable;
                            addUpdateBloc.clothModel.images =
                                itemimageaddBloc.images;
                            addUpdateBloc.clothModel.brand =
                                brandController.text;
                            addUpdateBloc.clothModel.material =
                                materialController.text;
                            addUpdateBloc.clothModel.price =
                                int.parse(priceController.text);
                            addUpdateBloc.clothModel.tags = tagsController.text;
                            addUpdateBloc.clothModel.metaTitle =
                                metaTitleController.text;
                            addUpdateBloc.clothModel.metaDescription =
                                metaDescriptionController.text;
                          }

                          addUpdateBloc
                              .add(SaveButtonPressedEvent(formkey: formkey));
                        },
                        text: 'save',
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
