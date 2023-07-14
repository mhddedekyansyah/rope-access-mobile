import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rope_access/models/jasa_model.dart';
import 'package:rope_access/repositories/jasa/jasa_repository.dart';

part 'jasa_event.dart';
part 'jasa_state.dart';

class JasaBloc extends Bloc<JasaEvent, JasaState> {
  final JasaRepository _jasaRepository;
  JasaBloc({required JasaRepository jasaRepository})
      : _jasaRepository = jasaRepository,
        super(JasaInitial()) {
    on<GetAllJasa>((event, emit) async {
      try {
        emit(JasaLoading());

        final List<JasaModel> jasas = await _jasaRepository.getAllJasa();

        emit(JasaLoaded(jasas: jasas));
      } catch (e) {
        emit(JasaFailed(message: e.toString()));
      }
    });
  }
}
