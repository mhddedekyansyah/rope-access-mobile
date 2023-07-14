part of 'jasa_bloc.dart';

abstract class JasaEvent extends Equatable {
  const JasaEvent();

  @override
  List<Object> get props => [];
}

class GetAllJasa extends JasaEvent {}
