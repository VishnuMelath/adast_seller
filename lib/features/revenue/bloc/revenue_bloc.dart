import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'revenue_event.dart';
part 'revenue_state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  RevenueBloc() : super(RevenueInitial()) {
    on<RevenueEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
