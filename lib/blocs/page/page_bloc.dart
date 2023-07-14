import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';

class PageBloc extends Bloc<PageEvent, int> {
  PageBloc() : super(0) {
    on<SetPageEvent>((event, emit) {
      emit(event.currentIndex);
    });
  }
}
