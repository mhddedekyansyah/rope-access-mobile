import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/repositories/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  CartBloc({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(const CartInitial()) {
    on<GetAllCart>((event, emit) async {
      try {
        emit(CartLoading());

        int totalPrice = 0;
        int totalItems = 0;
        final List<CartModel> carts = await _cartRepository.getAllCart();
        for (var cart in carts) {
          totalPrice += cart.product.price * cart.quantity;
          // totalPrice += int.parse(cart.product.price) * cart.quantity;
          totalItems += cart.quantity;
          //     int.parse(cart.product.price) * int.parse(cart.quantity);
          // totalItems += int.parse(cart.quantity);
        }

        emit(CartLoaded(
            carts: carts, totalPrice: totalPrice, totalItems: totalItems));
      } catch (e) {
        emit(CartFailed(message: e.toString()));
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        bool isSuccess = await _cartRepository.addToCart(
            productId: event.productId, quantity: event.quantity);

        if (isSuccess) {
          emit(const AddToCartSuccess());
        }
      } catch (e) {
        emit(const AddToCartFailed());
      }
      //   var state = this.state;
      //   if (state is CartLoaded) {
      //     try {
      //       CartModel newcart = await _cartRepository.addToCart(
      //           productId: event.productId, quantity: event.quantity);
      //       int totalPrice = state.totalPrice;
      //       int totalItems = state.totalItems;

      //       List<CartModel> carts = List.from(state.carts);

      //       emit(
      //         state.copyWith(
      //             carts: carts,
      //             totalPrice: totalPrice + (newcart.product.price * 1),
      //             totalItems: totalItems + 1),
      //       );
      //       final index = carts.indexWhere((cart) => cart.id == newcart.id);

      //       if (index > -1) {
      //         final updateCart = carts[index];
      //         carts[index] = CartModel(
      //             id: updateCart.id,
      //             product: updateCart.product,
      //             userId: updateCart.userId,
      //             quantity: updateCart.quantity + 1);
      //         // print('new cart ${newCarts.toString()}');
      //         emit(
      //           state.copyWith(
      //               carts: carts,
      //               totalPrice: totalPrice + (newcart.product.price * 1),
      //               totalItems: totalItems + 1),
      //         );
      //       } else {
      //         carts.add(
      //           CartModel(
      //             id: newcart.id,
      //             product: newcart.product,
      //             userId: newcart.userId,
      //             quantity: newcart.quantity,
      //           ),
      //         );
      //         emit(
      //           state.copyWith(
      //               carts: carts,
      //               totalPrice: newcart.product.price,
      //               totalItems: 1),
      //         );
      //       }
      //     } catch (e) {
      //       emit(CartFailed(message: e.toString()));
      //     }
      //   }
      // }, transformer: concurrent());

      // on<GetAllCart>((event, emit) async {
      //   try {
      //     emit(CartLoading());

      //     int totalPrice = 0;
      //     int totalItems = 0;
      //     final List<CartModel> carts = await _cartRepository.getAllCart();
      //     for (var cart in carts) {
      //       totalPrice += cart.product.price * cart.quantity;
      //       totalItems += cart.quantity;
      //     }

      //     emit(CartLoaded(
      //         carts: carts, totalPrice: totalPrice, totalItems: totalItems));
      //   } catch (e) {
      //     emit(CartFailed(message: e.toString()));
      //   }
    });

    on<RemoveCart>((event, emit) async {
      if (state is CartLoaded) {
        try {
          bool isSuccess = await _cartRepository.removeCart(event.cartModel);

          if (isSuccess) {
            List<CartModel> newCarts = List.from((state as CartLoaded).carts)
              ..removeWhere((cart) => cart.id == event.cartModel.id);
            int totalPrice = (state as CartLoaded).totalPrice;
            int totalItems = (state as CartLoaded).totalItems;

            // totalPrice: totalPrice -
            //         (int.parse(event.cartModel.product.price) *
            //             int.parse(event.cartModel.quantity)),
            emit(
              (state as CartLoaded).copyWith(
                carts: newCarts,
                totalPrice: totalPrice -
                    (event.cartModel.product.price * event.cartModel.quantity),
                // totalPrice: totalPrice -
                //     (int.parse(event.cartModel.product.price) *
                //         event.cartModel.quantity),
                totalItems: totalItems - event.cartModel.quantity,
              ),
            );
          }
        } catch (e) {
          emit(const CartFailed(message: 'remove cart failed'));
        }
      }
    }, transformer: concurrent());

    on<IncrementQuantityCart>((event, emit) async {
      if (state is CartLoaded) {
        try {
          bool isSuccess =
              await _cartRepository.incrementQuantityCart(event.cartModel);

          if (isSuccess) {
            int totalPrice = (state as CartLoaded).totalPrice;
            int totalItems = (state as CartLoaded).totalItems;
            final List<CartModel> carts =
                List.from((state as CartLoaded).carts);
            final index =
                carts.indexWhere((cart) => cart.id == event.cartModel.id);
            final updateCart = carts[index];
            final newCart = CartModel(
                id: updateCart.id,
                product: updateCart.product,
                userId: updateCart.userId,
                quantity: updateCart.quantity + 1);
            carts[index] = newCart;
            // print('new cart ${newCarts.toString()}');
            emit(
              (state as CartLoaded).copyWith(
                  carts: carts,
                  totalPrice: totalPrice + event.cartModel.product.price * 1,
                  // totalPrice: totalPrice +
                  //     (int.parse(event.cartModel.product.price) * 1),
                  totalItems: totalItems + 1),
            );
          }
        } catch (e) {
          emit(const CartFailed(message: 'increment quantity failed'));
        }
      }
    }, transformer: concurrent());

    on<DecrementQuantityCart>((event, emit) async {
      if (state is CartLoaded) {
        try {
          bool isSuccess =
              await _cartRepository.decrementQuantityCart(event.cartModel);

          if (isSuccess) {
            int totalPrice = (state as CartLoaded).totalPrice;
            int totalItems = (state as CartLoaded).totalItems;
            final List<CartModel> carts =
                List.from((state as CartLoaded).carts);
            final index =
                carts.indexWhere((cart) => cart.id == event.cartModel.id);
            final updateCart = carts[index];
            final newCart = CartModel(
                id: updateCart.id,
                product: updateCart.product,
                userId: updateCart.userId,
                quantity: updateCart.quantity - 1);
            carts[index] = newCart;
            // print('new cart ${newCarts.toString()}');
            emit(
              (state as CartLoaded).copyWith(
                  carts: carts,
                  totalPrice: totalPrice - event.cartModel.product.price * 1,
                  // totalPrice: totalPrice -
                  //     (int.parse(event.cartModel.product.price) * 1),
                  totalItems: totalItems - 1),
            );
          }
        } catch (e) {
          emit(const CartFailed(message: 'decrement quantity failed'));
        }
      }
    }, transformer: concurrent());
  }
}
