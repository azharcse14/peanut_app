import 'package:equatable/equatable.dart';

class OpenTradesEntity extends Equatable {
  final double currentPrice;
  final String comment;
  final int digits;
  final int login;
  final double openPrice;
  final DateTime openTime;
  final double profit;
  final double sl;
  final double swaps;
  final String symbol;
  final double tp;
  final int ticket;
  final int type;
  final double volume;

  const OpenTradesEntity({
    required this.currentPrice,
    required this.comment,
    required this.digits,
    required this.login,
    required this.openPrice,
    required this.openTime,
    required this.profit,
    required this.sl,
    required this.swaps,
    required this.symbol,
    required this.tp,
    required this.ticket,
    required this.type,
    required this.volume,
  });

  @override
  List<Object?> get props => [
        currentPrice,
        comment,
        digits,
        login,
        openPrice,
        openTime,
        profit,
        sl,
        swaps,
        symbol,
        tp,
        ticket,
        type,
        volume,
      ];
}
