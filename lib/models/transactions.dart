import 'package:json_annotation/json_annotation.dart';

part 'transactions.g.dart';

@JsonSerializable()
class Transaction {
  final int id;
  final String merchantName;
  final String merchantImage;
  final double amount;
  final String paymentMethod;
  final String status;
  final String date;

  Transaction({
    required this.id,
    required this.merchantName,
    required this.merchantImage,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

