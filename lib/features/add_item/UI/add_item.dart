import 'dart:developer';

import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/custom_button.dart';
import 'package:adast_seller/custom_widgets/custom_drop_down.dart';
import 'package:adast_seller/custom_widgets/custom_snackbar.dart';
import 'package:adast_seller/custom_widgets/item_image_add_button/UI/item_image_add_widget.dart';
import 'package:adast_seller/custom_widgets/item_image_add_button/bloc/itemimageadd_bloc.dart';
import 'package:adast_seller/custom_widgets/multi_drop_down/UI/multi_select.dart';
import 'package:adast_seller/custom_widgets/multi_drop_down/bloc/multi_dd_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/custom_textfield2.dart';
import '../bloc/add_update_bloc.dart';

class AddItem extends StatelessWidget {
  final ClothModel? clothModel;
  const AddItem({super.key,this.clothModel});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();

    //text editing controllers
    TextEditingController nameController = TextEditingController(text: clothModel?.name);
    TextEditingController descriptionController = TextEditingController(text: clothModel?.description );
    TextEditingController brandController = TextEditingController(text: clothModel?.brand);
    TextEditingController priceController = TextEditingController(text: clothModel?.price.toString());
    TextEditingController tagsController = TextEditingController(text: clothModel?.tags);
    TextEditingController metaTitleController = TextEditingController(text: clothModel?.metaTitle);
    TextEditingController metaDescriptionController = TextEditingController(text: clothModel?.metaDescription);
    TextEditingController materialController = TextEditingController(text: clothModel?.material);

    String category = '';
    String fit = '';
    List<String> sizes = [];

    //blocs
    ItemimageaddBloc itemimageaddBloc = ItemimageaddBloc();
    AddBloc addUpdateBloc = AddBloc();
    MultiDdBloc multiDdBloc = MultiDdBloc();

  
      itemimageaddBloc.images =clothModel?.images??[];
    

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item',
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
                CustomDropDown(
                  items: categoryOptios,
                  selectedValue: '',
                  label: 'category',
                  onChanged: (value) {
                    if (value != null) {
                      category = value;
                    }
                  },
                ),
                CustomDropDown(
                    items: fits,
                    selectedValue: '',
                    onChanged: (value) {
                      if (value != null) {
                        fit = value;
                      }
                    },
                    label: 'fit'),
                BlocProvider(
                  create: (context) => itemimageaddBloc,
                  child: const ItemImageAddWidget(),
                ),
                CustmMultiselectionDropdownT(
                  onOptionRemoved: (index, values) {
                    log(index.toString());
                    sizes.remove(values.label);
                    multiDdBloc.add(MultiDdUnSelectedEvent(size: values.label));
                  },
                    onOptionSelected: (values) {
                      sizes = values.map(
                        (e) {
                          return e.value!;
                        },
                      ).toList();
                      multiDdBloc.add(MultiDdSelectedEvent(sized: sizes));
                    },
                    multiDdBloc: multiDdBloc),
              
                
                CustomTextfield2(label: 'brand', controller: brandController),
                CustomTextfield2(
                    label: 'material', controller: materialController),
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
                          addUpdateBloc.clothModel = ClothModel(
                              sellerID:
                                  context.read<LoginBloc>().sellerModel!.email,
                              name: nameController.text,
                              description: descriptionController.text,
                              category: category,
                              fit: fit,
                              size: multiDdBloc.countMap,
                              images: itemimageaddBloc.images,
                              brand: brandController.text,
                              material: materialController.text,
                              price: int.parse(priceController.text),
                              tags: tagsController.text,
                              metaTitle: metaTitleController.text,
                              metaDescription: metaDescriptionController.text,
                    );
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
