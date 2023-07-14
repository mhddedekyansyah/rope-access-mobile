// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductLoaded({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class ProductLoading extends ProductState {}

class ProductFailed extends ProductState {
  final String message;
  const ProductFailed({
    required this.message,
  });
}
