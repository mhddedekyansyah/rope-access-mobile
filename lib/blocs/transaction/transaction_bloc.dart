import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rope_access/models/cart_model.dart';
import 'package:rope_access/models/transaction_model.dart';
import 'package:rope_access/repositories/transaction/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;
  TransactionBloc({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(TransactionInitial()) {
    on<CheckoutEvent>((event, emit) async {
      try {
        var state = this.state;
        if (state is TransactionLoaded) {
          List<TransactionModel> transactions = List.from(state.transactions);
          final TransactionModel transaction =
              await _transactionRepository.checkout(
                  address: event.address,
                  totalPrice: event.totalPrice,
                  carts: event.carts);

          transactions.add(transaction);
          emit(state.copyWith(transactions));
        }
      } catch (e) {
        emit(TransactionFailed(message: e.toString()));
      }
    });

    on<GetAllTransaction>((event, emit) async {
      try {
        List<TransactionModel> transactions =
            await _transactionRepository.getAllTransaction();

        emit(TransactionLoaded(transactions: transactions));
      } catch (e) {
        emit(TransactionFailed(message: e.toString()));
      }
    });
  }
}
