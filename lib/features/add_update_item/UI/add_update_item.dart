import 'package:adast_seller/%20themes/constants.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/custm_multiselection_dropdown.dart';
import 'package:adast_seller/custom_widgets/custom_button.dart';
import 'package:adast_seller/custom_widgets/custom_drop_down.dart';
import 'package:adast_seller/custom_widgets/item_image_add_button/UI/item_image_add_widget.dart';
import 'package:adast_seller/custom_widgets/item_image_add_button/bloc/itemimageadd_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../custom_widgets/custom_textfield2.dart';
import '../bloc/add_update_bloc.dart';

class AddUpdateItem extends StatelessWidget {
  const AddUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey();

    //text editing controllers
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController tagsController = TextEditingController();
    TextEditingController metaTitleController = TextEditingController();
    TextEditingController metaDescriptionController = TextEditingController();
    TextEditingController maxReservableController = TextEditingController();
    TextEditingController materialController = TextEditingController();

    String category = '';
    String fit = '';
    List<String> sizes = [];

    //blocs
    ItemimageaddBloc itemimageaddBloc = ItemimageaddBloc();
    AddUpdateBloc addUpdateBloc = AddUpdateBloc();

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
                CustmMultiselectionDropdown(
                  onOptionSelected: (values) {
                    sizes = values.map(
                      (e) {
                        return e.value!;
                      },
                    ).toList();
                  },
                ),
                CustomTextfield2(
                  label: 'stock quantity',
                  controller: quantityController,
                  number: true,
                ),
                CustomTextfield2(label: 'brand', controller: brandController),
                CustomTextfield2(
                    label: 'material', controller: materialController),
                CustomTextfield2(
                  label: 'price',
                  controller: priceController,
                  number: true,
                ),
                CustomTextfield2(
                  label: 'max reservable',
                  controller: maxReservableController,
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
                BlocBuilder<AddUpdateBloc, AddUpdateState>(
                  bloc: addUpdateBloc,
                  builder: (context, state) {
                    return CustomButton(
                      onTap: () {
                        addUpdateBloc.clothModel = ClothModel(
                            sellerID:
                                context.read<LoginBloc>().sellerModel!.email,
                            name: nameController.text,
                            description: descriptionController.text,
                            category: category,
                            fit: fit,
                            size: sizes,
                            images: itemimageaddBloc.images,
                            totalPeices: int.parse(quantityController.text),
                            brand: brandController.text,
                            material: materialController.text,
                            price: int.parse(priceController.text),
                            tags: tagsController.text,
                            metaTitle: metaTitleController.text,
                            metaDescription: metaDescriptionController.text,
                            maxReservable:
                                int.parse(maxReservableController.text));
                        addUpdateBloc
                            .add(SaveButtonPressedEvent(formkey: formkey));
                      },
                      text: 'save',
                    );
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
