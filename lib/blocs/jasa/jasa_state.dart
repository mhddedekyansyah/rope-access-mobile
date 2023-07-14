part of 'jasa_bloc.dart';

abstract class JasaState extends Equatable {
  const JasaState();

  @override
  List<Object> get props => [];
}

class JasaInitial extends JasaState {}

class JasaLoaded extends JasaState {
  final List<JasaModel> jasas;
  const JasaLoaded({
    required this.jasas,
  });

  @override
  List<Object> get props => [jasas];
}

class JasaLoading extends JasaState {}

class JasaFailed extends JasaState {
  final String message;
  const JasaFailed({
    required this.message,
  });
}
