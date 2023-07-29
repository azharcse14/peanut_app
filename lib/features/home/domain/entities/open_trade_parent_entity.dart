import 'package:equatable/equatable.dart';
import 'package:peanut_app/features/home/domain/entities/open_trades_entity.dart';

class OpenTradeParentEntity extends Equatable{
  final String? message;
  final List<OpenTradesEntity>? data;


  const OpenTradeParentEntity({required this.message, required this.data});

  @override
  List<Object?> get props => [message, data];
}