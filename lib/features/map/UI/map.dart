
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
import 'package:adast_seller/features/map/bloc/map_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool bottomsheet = false;
  bool map=true;
  GlobalKey<FormState> formkey = GlobalKey();
  final Set<Marker> markers = {};
  LatLng center = const LatLng(11.2588, 75.7804);
  late GoogleMapController mapController;
  MapBloc mapBloc = MapBloc();
  late ImageIconBloc imageIconBloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
            mapBloc.add(MapCurrentLocationTappedEvent(
                googleMapController: mapController));
          },
        ),
        body: BlocConsumer<MapBloc, MapState>(
          bloc: mapBloc,
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
            if (state is MapSaveErrorState) {
              customSnackBar(context, state.error);
            }
            if (state is MapMarkerShowState) {
              markers.clear();
              markers.add(state.marker);
            }
            if (state is MapBottomSheetState) {
              imageIconBloc = ImageIconBloc();

              showModalBottomSheet(
                // useSafeArea: true,
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
                                onPressed: () async{
                                  await Future.delayed(Duration(milliseconds: 50));

                                  bottomsheet=false;
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
                              mapBloc.add(MapSavePressedEvent(
                                  place: addressController.text,
                                  formkey: formkey,
                                  name: nameController.text,
                                  latLng: markers.first.position,
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
                GoogleMap(
                  markers: markers,

                  onTap: (latlng) {
                 
                    if (kIsWeb) {
                      if (!bottomsheet) {
                        bottomsheet = true;
                        mapBloc.add(MapTapedEvent(latLng: latlng));
                      }
                    } else {
                      mapBloc.add(MapTapedEvent(latLng: latlng));
                    }
                  },
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  // myLocationButtonEnabled: true,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: center, // Example coordinates (San Francisco)
                    zoom: 13.0,
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
                          'Complete the profile by adding location of your shop in the map and add the necessory info.',
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


