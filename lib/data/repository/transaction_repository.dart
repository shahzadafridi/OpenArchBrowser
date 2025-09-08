import '../../model/TransactionModel.dart';

abstract class TransactionRepository {
  Future<void> init();
  Future<void> insertTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String title);
  Future<void> clearAllTransactions();
}