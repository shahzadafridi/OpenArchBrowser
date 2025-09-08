import 'package:flutter/material.dart';
import '../../data/repository/transaction_repository.dart';

class MainViewModel extends ChangeNotifier {
  final TransactionRepository repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  MainViewModel({required this.repository});

  Future<void> init() async {
    await repository.init();
  }

}