import 'package:adast_seller/%20themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../custom_widgets/custom_appbar.dart';
import '../bloc/reservation_status_bloc.dart';
import 'widgets/cloth_detail.dart';
import 'widgets/custom_stepper.dart';
import 'widgets/network_image.dart';
import 'widgets/seller_tile.dart';
import 'widgets/status.dart';

class ReservationStatusScreen extends StatelessWidget {
  final ReservationStatusBloc reservationStatusBloc;
  const ReservationStatusScreen(
      {super.key, required this.reservationStatusBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: BlocBuilder<ReservationStatusBloc, ReservationStatusState>(
            bloc: reservationStatusBloc,
            builder: (context, state) {
              return Visibility(
                visible: reservationStatusBloc.reservationModel.status !=
                    ReservationStatus.purchased.name,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    reservationStatusBloc.add(ReservationMarkAsSoldEvent());
                  },
                  label: const Text('Mark as sold'),
                ),
              );
            },
          ),
          appBar: customAppBar('Reservation Details', context),
          body: BlocBuilder<ReservationStatusBloc, ReservationStatusState>(
            bloc: reservationStatusBloc,
            builder: (context, state) {
              if (state is ReservationTileLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SellerTile(
                                      reservationStatusBloc:
                                          reservationStatusBloc),
                                  clothDetail(reservationStatusBloc)
                                ],
                              ),
                            ),
                            networkImageUsingWidth(
                              reservationStatusBloc.clothModel!.images.first,
                              80,
                            )
                          ],
                        ),
                        customStepper(reservationStatusBloc.reservationModel),
                        statusWidget(reservationStatusBloc.reservationModel)
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
