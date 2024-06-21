// import 'dart:developer';

// import 'package:adast_seller/%20themes/constants.dart';
// import 'package:adast_seller/%20themes/themes.dart';
// import 'package:adast_seller/custom_widgets/custom_button.dart';
// import 'package:adast_seller/custom_widgets/custom_drop_down.dart';
// import 'package:adast_seller/custom_widgets/custom_snackbar.dart';
// import 'package:adast_seller/custom_widgets/item_image_add_button/UI/item_image_add_widget.dart';
// import 'package:adast_seller/custom_widgets/item_image_add_button/bloc/itemimageadd_bloc.dart';
// import 'package:adast_seller/custom_widgets/multi_drop_down/UI/multi_select.dart';
// import 'package:adast_seller/custom_widgets/multi_drop_down/bloc/multi_dd_bloc.dart';
// import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
// import 'package:adast_seller/features/update_item/bloc/update_item_bloc.dart';
// import 'package:adast_seller/models/cloth_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';

// import '../../../custom_widgets/custom_textfield2.dart';
// import '../../add_item/bloc/add_update_bloc.dart';

// class AddItem extends StatelessWidget {
//   final ClothModel clothModel;
//   const AddItem({super.key, required this.clothModel});

//   @override
//   Widget build(BuildContext context) {
//     GlobalKey<FormState> formkey = GlobalKey();

//     //text editing controllers
//     TextEditingController nameController = TextEditingController();
//     TextEditingController descriptionController = TextEditingController();
//     TextEditingController quantityController = TextEditingController();
//     TextEditingController brandController = TextEditingController();
//     TextEditingController priceController = TextEditingController();
//     TextEditingController tagsController = TextEditingController();
//     TextEditingController metaTitleController = TextEditingController();
//     TextEditingController metaDescriptionController = TextEditingController();
//     TextEditingController maxReservableController = TextEditingController();
//     TextEditingController materialController = TextEditingController();

//     String category = '';
//     String fit = '';
//     List<String> sizes = [];
//     Map<String, List<int>> countMap = {};

//     //blocs
//     ItemimageaddBloc itemimageaddBloc = ItemimageaddBloc();
//     UpdateItemBloc updateItemBloc = UpdateItemBloc(clothModel);
//     MultiDdBloc multiDdBloc = MultiDdBloc();
//     updateItemBloc.clothModel=clothModel;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Add Item',
//           style: greenTextStyle,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: formkey,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
//             child: Column(
//               children: [
//                 CustomTextfield2(
//                     label: 'item name', controller: nameController),
//                 CustomTextfield2(
//                   label: 'description',
//                   controller: descriptionController,
//                   maxLines: 4,
//                 ),
//                 CustomDropDown(
//                   items: categoryOptios,
//                   selectedValue: '',
//                   label: 'category',
//                   onChanged: (value) {
//                     if (value != null) {
//                       category = value;
//                     }
//                   },
//                 ),
//                 CustomDropDown(
//                     items: fits,
//                     selectedValue: '',
//                     onChanged: (value) {
//                       if (value != null) {
//                         fit = value;
//                       }
//                     },
//                     label: 'fit'),
//                 BlocProvider(
//                   create: (context) => itemimageaddBloc,
//                   child: const ItemImageAddWidget(),
//                 ),
//                 CustmMultiselectionDropdownT(
//                   onOptionRemoved: (index, values) {
//                     log(index.toString());
//                     sizes.remove(values.label);
//                     multiDdBloc.add(MultiDdUnSelectedEvent(size: values.label));
//                   },
//                     onOptionSelected: (values) {
//                       sizes = values.map(
//                         (e) {
//                           return e.value!;
//                         },
//                       ).toList();
//                       multiDdBloc.add(MultiDdSelectedEvent(sized: sizes));
//                     },
//                     multiDdBloc: multiDdBloc),
              
//                 CustomTextfield2(
//                   label: 'stock quantity',
//                   controller: quantityController,
//                   number: true,
//                 ),
//                 CustomTextfield2(label: 'brand', controller: brandController),
//                 CustomTextfield2(
//                     label: 'material', controller: materialController),
//                 CustomTextfield2(
//                   label: 'price',
//                   controller: priceController,
//                   number: true,
//                 ),
//                 CustomTextfield2(
//                   label: 'max reservable',
//                   controller: maxReservableController,
//                   number: true,
//                 ),
//                 CustomTextfield2(label: 'tags', controller: tagsController),
//                 CustomTextfield2(
//                     label: "meta title", controller: metaTitleController),
//                 CustomTextfield2(
//                   label: 'meta description',
//                   controller: metaDescriptionController,
//                   maxLines: 4,
//                 ),
//                 BlocConsumer<UpdateItemBloc, UpdateItemState>(
//                   listener: (context, state) {
//                     if (state is UpdateErrorState) {
//                       customSnackBar(context, state.error);
//                     } else if (state is AddUpadateSavedSuccessState) {
//                       customSnackBar(context, 'Saved successfully');
//                       Navigator.pop(context, updateItemBloc.clothModel);
//                     }
//                   },
//                   bloc: updateItemBloc,
//                   builder: (context, state) {
//                     if (state is SaveButtonPressedState) {
//                       return CustomButton(
//                         onTap: () {},
//                         text: '',
//                         loading: true,
//                       );
//                     } else {
//                       return CustomButton(
//                         onTap: () {
//                           updateItemBloc.clothModel = ClothModel(
//                               sellerID:
//                                   context.read<LoginBloc>().sellerModel!.email,
//                               name: nameController.text,
//                               description: descriptionController.text,
//                               category: category,
//                               fit: fit,
//                               size: multiDdBloc.countMap,
//                               images: itemimageaddBloc.images,
//                               totalPeices: int.parse(quantityController.text),
//                               brand: brandController.text,
//                               material: materialController.text,
//                               price: int.parse(priceController.text),
//                               tags: tagsController.text,
//                               metaTitle: metaTitleController.text,
//                               metaDescription: metaDescriptionController.text,
//                     );
//                           updateItemBloc
//                               .add(UpdateButtonClickedEvent(formkey: formkey));
//                         },
//                         text: 'save',
//                       );
//                     }
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
