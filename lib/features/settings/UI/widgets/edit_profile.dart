import 'dart:developer';

import 'package:adast_seller/custom_widgets/image_icon/UI/image_icon.dart';
import 'package:adast_seller/custom_widgets/image_icon/bloc/image_icon_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/models/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../custom_widgets/custom_snackbar.dart';
import '../../../add_update_item/UI/widgets/custom_textfield.dart';
import '../../bloc/settings_bloc.dart';
import 'custom_save_button.dart';


void editProfile(BuildContext context) {
  SettingsBloc settingsBloc = context.read();
  ImageIconBloc imageIconBloc = ImageIconBloc();
  SellerModel sellerModel = context.read<LoginBloc>().sellerModel!;
  TextEditingController nameController =
      TextEditingController(text: sellerModel.name);
     TextEditingController placeController =
      TextEditingController(text: sellerModel.place);
  ValueNotifier<bool> loading = ValueNotifier(false);
    log(sellerModel.image.toString());
    imageIconBloc.imageUrl=sellerModel.image;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => BlocListener<SettingsBloc, SettingsState>(
            bloc: settingsBloc,
            listener: (context, state) {
              if (state is SettingsSaveSuccessState) {
                context.read<LoginBloc>().sellerModel=sellerModel;

                customSnackBar(context, 'updated succesfully');
                Navigator.pop(context);
              } else if (state is SettingsErrorState) {
                loading.value = false;
                customSnackBar(context, state.error);
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocProvider(
                          create: (context) => imageIconBloc,
                          child: const ImageIconWidget(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomTextfield(
                              label: 'Name', controller: nameController),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomTextfield(
                              label: 'Place', controller: placeController),
                        ),
                        Row(
                          children: [
                            customSaveCancelButton(onTap: () {
                              Navigator.pop(context);
                            }, save: false),
                            customSaveCancelButton(
                                onTap: () {
                                  log(imageIconBloc.imageUrl.toString());
                                  if (nameController.text.trim().isNotEmpty) {
                                    loading.value = true;
                                    sellerModel.name = nameController.text;
                                    sellerModel.image = imageIconBloc.imageUrl;
                                    sellerModel.place=placeController.text;
                                    settingsBloc.add(SettingsEditUserSaveButtonPressedEvent(sellerModel: sellerModel));
                                  }
                                },
                                loading: loading),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
}
