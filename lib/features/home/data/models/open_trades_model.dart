import 'package:peanut_app/features/home/domain/entities/open_trades_entity.dart';

class OpenTradesModel extends OpenTradesEntity {
  const OpenTradesModel({
    required super.currentPrice,
    required super.comment,
    required super.digits,
    required super.login,
    required super.openPrice,
    required super.openTime,
    required super.profit,
    required super.sl,
    required super.swaps,
    required super.symbol,
    required super.tp,
    required super.ticket,
    required super.type,
    required super.volume,
  });

  OpenTradesModel copyWith({
    double? currentPrice,
    String? comment,
    int? digits,
    int? login,
    double? openPrice,
    DateTime? openTime,
    double? profit,
    double? sl,
    double? swaps,
    String? symbol,
    double? tp,
    int? ticket,
    int? type,
    double? volume,
  }) =>
      OpenTradesModel(
        currentPrice: currentPrice ?? this.currentPrice,
        comment: comment ?? this.comment,
        digits: digits ?? this.digits,
        login: login ?? this.login,
        openPrice: openPrice ?? this.openPrice,
        openTime: openTime ?? this.openTime,
        profit: profit ?? this.profit,
        sl: sl ?? this.sl,
        swaps: swaps ?? this.swaps,
        symbol: symbol ?? this.symbol,
        tp: tp ?? this.tp,
        ticket: ticket ?? this.ticket,
        type: type ?? this.type,
        volume: volume ?? this.volume,
      );

  factory OpenTradesModel.init() => OpenTradesModel(
        currentPrice: 0.0,
        comment: '',
        digits: 0,
        login: 0,
        openPrice: 0.0,
        openTime: DateTime.now(),
        profit: 0.0,
        sl: 0.0,
        swaps: 0.0,
        symbol: '',
        tp: 0,
        ticket: 0,
        type: 0,
        volume: 0.0,
      );

  factory OpenTradesModel.fromJson(Map<String, dynamic> json) =>
      OpenTradesModel(
        currentPrice: json["currentPrice"]?.toDouble()??0.0,
        comment: json["comment"]??'',
        digits: json["digits"]??0,
        login: json["login"]??0,
        openPrice: json["openPrice"]?.toDouble()??0.0,
        openTime: DateTime.parse(json["openTime"])??DateTime.now(),
        profit: json["profit"]?.toDouble()??0.0,
        sl: json["sl"]?.toDouble()??0.0,
        swaps: json["swaps"]?.toDouble()??0.0,
        symbol: json["symbol"]??'',
        tp: json["tp"]??0.0,
        ticket: json["ticket"]??0,
        type: json["type"]??0,
        volume: json["volume"]?.toDouble()??0.0,
      );
}
