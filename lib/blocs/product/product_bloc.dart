import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rope_access/models/product_model.dart';
import 'package:rope_access/repositories/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitial()) {
    on<GetAllProduct>((event, emit) async {
      try {
        emit(ProductLoading());

        final List<ProductModel> products =
            await _productRepository.getAllProduct();

        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductFailed(message: e.toString()));
      }
    });
  }
}
