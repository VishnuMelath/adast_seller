import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  CompleteProfileBloc() : super(CompleteProfileInitial()) {
    on<CompleteProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
