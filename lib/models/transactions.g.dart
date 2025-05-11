// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: (json['id'] as num).toInt(),
      merchantName: json['merchantName'] as String,
      merchantImage: json['merchantImage'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchantName': instance.merchantName,
      'merchantImage': instance.merchantImage,
      'amount': instance.amount,
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'date': instance.date,
    };
