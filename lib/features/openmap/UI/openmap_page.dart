import 'dart:developer';

import 'package:adast_seller/%20themes/colors_shemes.dart';
import 'package:adast_seller/%20themes/themes.dart';
import 'package:adast_seller/custom_widgets/custom_button.dart';
import 'package:adast_seller/custom_widgets/custom_snackbar.dart';
import 'package:adast_seller/features/add_update_item/UI/widgets/custom_textfield.dart';
import 'package:adast_seller/custom_widgets/image_icon/UI/image_icon.dart';
import 'package:adast_seller/custom_widgets/image_icon/bloc/image_icon_bloc.dart';
import 'package:adast_seller/features/drawer/UI/drawer.dart';
import 'package:adast_seller/features/drawer/bloc/drawer_bloc.dart';
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:adast_seller/features/openmap/bloc/openmap_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenMapScreen extends StatefulWidget {
  const OpenMapScreen({super.key});

  @override
  State<OpenMapScreen> createState() => _OpenMapScreenState();
}

class _OpenMapScreenState extends State<OpenMapScreen> {
  bool bottomsheet = false;
  bool map = true;
  GlobalKey<FormState> formkey = GlobalKey();
  final List<Marker> markers = [];
  LatLng center = LatLng(11.2588, 75.7804);
  OpenmapBloc openmapBloc = OpenmapBloc();
  late ImageIconBloc imageIconBloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: green,
          child: const Icon(
            Icons.my_location_sharp,
            color: white,
          ),
          onPressed: () {
            openmapBloc.add(
                MapCurrentLocationTappedEvent(mapController: mapController));
          },
        ),
        body: BlocConsumer<OpenmapBloc, OpenmapState>(
          bloc: openmapBloc,
          listener: (context, state) {
            if (state is MapNavigateToHomeState) {
              context.read<LoginBloc>().sellerModel = state.sellerModel;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => DrawerBloc(),
                    child: const DrawerPage(),
                  ),
                ),
                (route) => false,
              );
            }
            if(state is MapCurrentLoacationState)
            {
              try {
  mapController.move(state.current,13.0);
} on Exception catch (e) {
  log(e.toString());
}
            }
            if (state is MapSaveErrorState) {
              customSnackBar(context, state.error);
            }
            if (state is MapMarkerShowState) {
              markers.clear();
              markers.add(Marker(
                child: Icon(Icons.location_history),
                width: 80.0,
                height: 80.0,
                point: LatLng(
                    state.marker.point.latitude, state.marker.point.longitude),
              ));
            }
            if (state is MapBottomSheetState) {
              imageIconBloc = ImageIconBloc();

              showModalBottomSheet(
                isDismissible: false,
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      Duration(milliseconds: 50));

                                  bottomsheet = false;
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: BlocProvider<ImageIconBloc>(
                                create: (context) => imageIconBloc,
                                child: const ImageIconWidget(),
                              ),
                            ),
                            Expanded(
                                child: CustomTextfield(
                                    label: 'Shop Name',
                                    controller: nameController))
                          ],
                        ),
                        CustomTextfield(
                          label: 'Place',
                          controller: addressController,
                          maxLines: 4,
                        ),
                        CustomButton(
                            onTap: () async {
                              openmapBloc.add(MapSavePressedEvent(
                                  place: addressController.text,
                                  formkey: formkey,
                                  name: nameController.text,
                                  latLng: markers.first.point,
                                  image: imageIconBloc.imageUrl,
                                  email: context
                                      .read<LoginBloc>()
                                      .sellerModel!
                                      .email));
                            },
                            text: 'save')
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                FlutterMap(
                  mapController: mapController,
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                  ],
                  options: MapOptions(
                    initialCenter: center,
                    initialZoom: 13.0,
                    onTap: (tapPosition, latlng) {
                      if (kIsWeb) {
                        if (!bottomsheet) {
                          bottomsheet = true;
                          openmapBloc.add(MapTapedEvent(latLng: latlng));
                        }
                      } else {
                        openmapBloc.add(MapTapedEvent(latLng: latlng));
                      }
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Tap on the map to add location of your shop in the map and add the necessory info.',
                          style: whiteTextStyle,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
