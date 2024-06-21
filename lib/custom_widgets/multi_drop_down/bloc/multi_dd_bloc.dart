import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'multi_dd_event.dart';
part 'multi_dd_state.dart';

class MultiDdBloc extends Bloc<MultiDdEvent, MultiDdState> {
    Map<String, dynamic> countMap={};
  MultiDdBloc() : super(MultiDdInitial()) {
    on<MultiDdSelectedEvent>(multiDdSelectedEvent);
     on<MultiDdUnSelectedEvent>(multiDdUnSelectedEvent);
  }

  FutureOr<void> multiDdSelectedEvent(MultiDdSelectedEvent event, Emitter<MultiDdState> emit) {
    for (var element in event.sized) {
      if(!countMap.containsKey(element))
      {
        countMap[element]=[0,0];
      }
    }
    emit(MultiDdOptionChangedState());
  }


  FutureOr<void> multiDdUnSelectedEvent(MultiDdUnSelectedEvent event, Emitter<MultiDdState> emit) {
    countMap.remove(event.size);
  }
}
