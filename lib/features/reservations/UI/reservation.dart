import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../ themes/colors_shemes.dart';
import '../../../models/reservation_model.dart';
import '../../reservation_status/UI/reservation_status_screen.dart';
import '../../reservation_status/bloc/reservation_status_bloc.dart';
import '../bloc/reservations_bloc.dart';
import '../methods/filter_reservations.dart';
import 'widgets/filter_reservations_widget.dart';
import 'widgets/loaded_tile.dart';
import 'widgets/loading_container.dart';

class ReservationsList extends StatelessWidget {
  const ReservationsList({super.key});

  @override
  Widget build(BuildContext context) {
    ReservationsBloc reservationsBloc = ReservationsBloc();
    final email = context.read<LoginBloc>().sellerModel!.email;
    reservationsBloc.add(ReservationInitialEvent(email: email));
    return Container(
      color: white,
      child: SafeArea(
          child: RefreshIndicator(
            onRefresh: ()async {
              reservationsBloc.add(ReservationInitialEvent(email: email));
            },
            child: Scaffold(
                    backgroundColor: backgroundColor,
                    body: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [filterReservationsWidget(context, reservationsBloc),
              Expanded(
                child: BlocBuilder<ReservationsBloc, ReservationsState>(
                  bloc: reservationsBloc,
                  buildWhen: (previous, current) {
                    return current is ReservationsLoadedState ||
                        current is ReservationsLoadingState;
                  },
                  builder: (context, state) {
                    if (state is ReservationsLoadingState) {
                      return loadingTile();
                    } else {
                      List<ReservationModel> filteredList =
                          reservationsBloc.reservations;
                      if (reservationsBloc.filter != 'All') {
                        filteredList = filterReservations(
                            reservationsBloc.filter, reservationsBloc.reservations);
                      }
                      if (filteredList.isEmpty) {
                        return const Center(
                          child: Text('no reservations'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            var reservationDetails = filteredList[index];
                            var reservationStatusBloc = ReservationStatusBloc(
                                reservationModel: reservationDetails);
                            reservationStatusBloc.reservationModel = reservationDetails;
                            reservationStatusBloc.add(ReservationTileLoadingEvent(
                                itemId: reservationDetails.itemId,
                                userId: reservationDetails.userId));
                            return BlocBuilder(
                              bloc: reservationStatusBloc,
                              buildWhen: (previous, current) =>
                                  current is ReservationTileLoadingState ||
                                  current is ReservationTileLoadedState,
                              builder: (context, state) {
                                if (state is ReservationTileLoadingState) {
                                  return loadingTile();
                                } else if (state is ReservationTileLoadedState) {
                                  return loadedTile(reservationStatusBloc, () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReservationStatusScreen(
                                            reservationStatusBloc:
                                                reservationStatusBloc,
                                          ),
                                        )).then(
                                      (value) {
                                        if (reservationStatusBloc.reload != false) {
                                          reservationStatusBloc.reload = false;
                                          reservationsBloc.add(
                                              ReservationInitialEvent(email: email));
                                        }
                                      },
                                    );
                                  }, context);
                                } else {
                                  return loadingTile();
                                }
                              },
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ],
                    ),
                  ),
          )),
    );
  }
}
