import 'package:adast_seller/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddUpdateItem extends StatelessWidget {
  const AddUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey =GlobalKey();
    TextEditingController nameController=TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController quantityController =TextEditingController();
    TextEditingController brandController=TextEditingController();
    TextEditingController priceController=TextEditingController();
    TextEditingController tagsController =TextEditingController();
    TextEditingController metaTitleController=TextEditingController();
    TextEditingController metaDescriptionController =TextEditingController();

    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
          children: [ 
            CustomTextfield(label: 'item name', controller: nameController),
            CustomTextfield(label: 'description', controller: descriptionController,maxLines: 6,),
            CustomTextfield(label: 'stock Quantity', controller: quantityController),
            CustomTextfield(label: 'brand', controller: brandController),
            CustomTextfield(label: 'price', controller: priceController),
            CustomTextfield(label: 'tags', controller: tagsController),
            CustomTextfield(label: "meta title", controller: metaTitleController),
            CustomTextfield(label: 'meta description', controller: metaDescriptionController)
          ],
      ),),
    );
  }
}