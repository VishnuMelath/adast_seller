import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_update_event.dart';
part 'add_update_state.dart';

class AddUpdateBloc extends Bloc<AddUpdateEvent, AddUpdateState> {
  AddUpdateBloc() : super(AddUpdateInitial()) {
    on<AddUpdateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
